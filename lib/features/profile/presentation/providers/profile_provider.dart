import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/profile_remote_datasource.dart';

import '../../data/repositories/profile_repository_impl.dart';

import '../../domain/entities/user_entity.dart';

import '../../domain/usecases/get_profile_usecase.dart';

final profileProvider =
StreamProvider<UserEntity>((ref) {

  final datasource =
  ProfileRemoteDatasource();

  final repository =
  ProfileRepositoryImpl(
    datasource,
  );

  final usecase =
  GetProfileUseCase(
    repository,
  );

  return usecase();
});