import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/course_repository.dart';
import '../datasource/course_remote_datasource.dart';

class CourseRepositoryImpl
    implements CourseRepository {

  final CourseRemoteDataSource remoteDataSource;

  CourseRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<CourseEntity>> getCourses() {

    return remoteDataSource.getCourses();
  }
}