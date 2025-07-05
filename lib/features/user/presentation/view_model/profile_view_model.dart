import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jobmaniaapp/features/user/domain/entity/profile_entity.dart';
import 'package:jobmaniaapp/features/user/domain/repository/user_profile_repository.dart';

class ProfileViewModel extends Cubit<ProfileEntity?> {
  final UserProfileRepository remoteRepo;
  final UserProfileRepository localRepo;

  ProfileViewModel({required this.remoteRepo, required this.localRepo})
    : super(null);

  Future<void> loadProfile(String userId) async {
    try {
      final remoteProfile = await remoteRepo.getProfile(userId);

      if (remoteProfile != null) {
        emit(remoteProfile);
        await localRepo.updateProfile(remoteProfile);
      } else {
        final localProfile = await localRepo.getProfile(userId);

        emit(localProfile);
      }
    } catch (e) {
      final localProfile = await localRepo.getProfile(userId);
      emit(localProfile);
    }
  }

  Future<void> updateProfile(ProfileEntity updated) async {
    emit(updated);
    await localRepo.updateProfile(updated);
    await remoteRepo.updateProfile(updated);
  }
}
