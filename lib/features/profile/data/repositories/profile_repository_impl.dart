import '../../domain/entities/user_entity.dart';

import '../../domain/repositories/profile_repository.dart';

import '../datasource/profile_remote_datasource.dart';

import '../models/user_model.dart';

class ProfileRepositoryImpl
    implements ProfileRepository {

  final ProfileRemoteDatasource
  datasource;

  ProfileRepositoryImpl(
      this.datasource,
      );

  @override
  Stream<UserEntity>
  getProfile() {

    return datasource
        .getProfile();
  }

  @override
  Future<void> saveProfile(
      UserEntity user,
      ) async {

    final model = UserModel(

      uid: user.uid,

      nom: user.nom,

      prenom: user.prenom,

      email: user.email,

      filiere: user.filiere,

      niveau: user.niveau,

      photoUrl:
      user.photoUrl,
    );

    await datasource
        .saveProfile(model);
  }
}