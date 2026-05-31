import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/course_remote_datasource.dart';

import '../../data/repositories/course_repository_impl.dart';

import '../../domain/entities/course_entity.dart';

import '../../domain/usecases/get_courses_usecase.dart';

import '../../../../core/services/cache_service.dart';

import '../../../../core/services/notification_service.dart';

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

  final notificationService =
  NotificationService();

  // =========================
  // COURS DEJA TRAITES
  // =========================

  List<String> knownCourses = [];

  try {

    await for (final courses
    in usecase()) {

      // =========================
      // NOTIFICATIONS
      // =========================

      for (final course
      in courses) {

        final uniqueCourseKey =

            '${course.titre}_'
            '${course.date}_'
            '${course.heureDebut}';

        // =========================
        // EVITER DUPLICATIONS
        // =========================

        if (!knownCourses
            .contains(
          uniqueCourseKey,
        )) {

          knownCourses.add(
            uniqueCourseKey,
          );

          // =========================
          // NOTIFICATION AJOUT COURS
          // =========================

          await notificationService
              .showNotification(

            title:
            'Nouveau cours',

            body:
            '${course.titre} ajouté à l’emploi du temps',
          );

          // =========================
          // RAPPEL AUTOMATIQUE
          // =========================

          try {

            // =========================
            // FORMAT DATE
            // 2026-05-26
            // =========================

            final dateParts =
            course.date
                .split('-');

            // =========================
            // FORMAT HEURE
            // 14:45
            // =========================

            final hourParts =
            course.heureDebut
                .split(':');

            // =========================
            // CREATION DATETIME
            // =========================

            final courseDateTime =
            DateTime(

              int.parse(
                dateParts[0],
              ),

              int.parse(
                dateParts[1],
              ),

              int.parse(
                dateParts[2],
              ),

              int.parse(
                hourParts[0],
              ),

              int.parse(
                hourParts[1],
              ),
            );

            // =========================
            // TEST RAPIDE
            // =========================
            // TEMPORAIREMENT :
            // 1 minute avant
            // =========================

            final reminderTime =
            courseDateTime.subtract(

              const Duration(
                minutes: 1,
              ),
            );

            // =========================
            // DEBUG
            // =========================

            print(
              'Cours : $courseDateTime',
            );

            print(
              'Rappel : $reminderTime',
            );

            print(
              'Maintenant : ${DateTime.now()}',
            );

            // =========================
            // DATE FUTURE ?
            // =========================

            if (reminderTime
                .isAfter(
              DateTime.now(),
            )) {

              await notificationService

                  .scheduleNotification(

                title:
                'Rappel de cours',

                body:
                '${course.titre} commence bientôt',

                scheduledDate:
                reminderTime,
              );

              print(
                'Notification programmée',
              );

            } else {

              print(
                'Rappel ignoré : date passée',
              );
            }

          } catch (e) {

            print(
              'Erreur rappel : $e',
            );
          }
        }
      }

      // =========================
      // SAUVEGARDE HIVE
      // =========================

      final coursesData =
      courses.map((course) {

        return {

          'titre':
          course.titre,

          'enseignant':
          course.enseignant,

          'salle':
          course.salle,

          'date':
          course.date,

          'heureDebut':
          course.heureDebut,

          'heureFin':
          course.heureFin,
        };

      }).toList();

      await cacheService
          .saveCourses(
        coursesData,
      );

      // =========================
      // ENVOI UI
      // =========================

      yield courses;
    }

  } catch (e) {

    print(
      'Mode offline activé',
    );

    // =========================
    // RECUPERATION HIVE
    // =========================

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

        date:
        course['date'],

        heureDebut:
        course['heureDebut'],

        heureFin:
        course['heureFin'],
      );

    }).toList();

    yield offlineCourses;
  }
});