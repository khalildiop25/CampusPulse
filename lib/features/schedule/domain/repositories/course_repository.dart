import '../entities/course_entity.dart';

abstract class CourseRepository {
  Stream<List<CourseEntity>> getCourses();
}