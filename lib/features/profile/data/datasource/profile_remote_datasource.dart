import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class ProfileRemoteDatasource {

  final firestore =
      FirebaseFirestore.instance;

  final auth =
      FirebaseAuth.instance;

  // =========================
  // RECUPERER PROFIL
  // =========================

  Stream<UserModel> getProfile() {

    final uid =
        auth.currentUser!.uid;

    return firestore

        .collection('users')

        .doc(uid)

        .snapshots()

        .map((doc) {

      return UserModel.fromMap(
        doc.data()!,
      );
    });
  }

  // =========================
  // SAUVEGARDER PROFIL
  // =========================

  Future<void> saveProfile(
      UserModel user,
      ) async {

    await firestore

        .collection('users')

        .doc(user.uid)

        .set(
      user.toMap(),
    );
  }
}