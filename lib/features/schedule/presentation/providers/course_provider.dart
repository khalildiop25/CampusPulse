import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/course_remote_datasource.dart';
import '../../data/repositories/course_repository_impl.dart';
import '../../domain/entities/course_entity.dart';
import '../../domain/usecases/get_courses_usecase.dart';

final courseProvider =
StreamProvider<List<CourseEntity>>((ref) {

  final datasource =
  CourseRemoteDataSource();

  final repository =
  CourseRepositoryImpl(datasource);

  final usecase =
  GetCoursesUseCase(repository);

  return usecase();
});