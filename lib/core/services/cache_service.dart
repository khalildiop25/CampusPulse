import 'package:hive/hive.dart';

class CacheService {

  static const String boxName =
      'coursesBox';

  Future<void> saveCourses(

      List<Map<String, dynamic>> courses,

      ) async {

    final box =
    await Hive.openBox(boxName);

    await box.put(
      'courses',
      courses,
    );
    print('Cours sauvegardés dans Hive');
  }

  Future<List<dynamic>> getCourses()
  async {

    final box =
    await Hive.openBox(boxName);

    return box.get(
      'courses',
      defaultValue: [],
    );
  }
  Future<bool> hasCachedCourses()
  async {

    final box =
    await Hive.openBox(boxName);

    final courses =
    box.get('courses');

    return courses != null &&
        courses.isNotEmpty;
  }
}