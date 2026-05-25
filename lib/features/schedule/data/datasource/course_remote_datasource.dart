import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_model.dart';

class CourseRemoteDataSource {

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  Stream<List<CourseModel>> getCourses() {

    return firestore
        .collection('courses')
        .snapshots()
        .map((snapshot) {

      return snapshot.docs.map((doc) {

        return CourseModel.fromFirestore(
          doc.data(),
        );

      }).toList();
    });
  }
}