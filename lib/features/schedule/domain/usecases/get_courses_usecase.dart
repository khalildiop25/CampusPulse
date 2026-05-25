import '../entities/course_entity.dart';
import '../repositories/course_repository.dart';

class GetCoursesUseCase {

  final CourseRepository repository;

  GetCoursesUseCase(this.repository);

  Stream<List<CourseEntity>> call() {

    return repository.getCourses();
  }
}