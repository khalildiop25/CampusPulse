import '../entities/user_entity.dart';

abstract class ProfileRepository {

  Stream<UserEntity>
  getProfile();

  Future<void> saveProfile(
      UserEntity user,
      );
}