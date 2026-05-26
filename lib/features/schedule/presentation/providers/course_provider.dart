import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/course_remote_datasource.dart';

import '../../data/repositories/course_repository_impl.dart';

import '../../domain/entities/course_entity.dart';

import '../../domain/usecases/get_courses_usecase.dart';

import '../../../../core/services/cache_service.dart';

final courseProvider =
StreamProvider<List<CourseEntity>>((
    ref,
    ) async* {

  final cacheService =
  CacheService();

  final datasource =
  CourseRemoteDataSource();

  final repository =
  CourseRepositoryImpl(
    datasource,
  );

  final usecase =
  GetCoursesUseCase(
    repository,
  );

  try {

    await for (final courses
    in usecase()) {

      final coursesData =
      courses.map((course) {

        return {

          'titre':
          course.titre,

          'enseignant':
          course.enseignant,

          'salle':
          course.salle,

          'heureDebut':
          course.heureDebut,

          'heureFin':
          course.heureFin,
        };

      }).toList();

      await cacheService.saveCourses(
        coursesData,
      );

      yield courses;
    }

  } catch (e) {

    print(
      'Mode offline activé',
    );

    final cachedCourses =
    await cacheService
        .getCourses();

    final offlineCourses =
    cachedCourses.map((course) {

      return CourseEntity(

        titre:
        course['titre'],

        enseignant:
        course['enseignant'],

        salle:
        course['salle'],

        heureDebut:
        course['heureDebut'],

        heureFin:
        course['heureFin'],
      );

    }).toList();

    yield offlineCourses;
  }
});