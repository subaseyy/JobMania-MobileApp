import 'package:jobmaniaapp/features/user/domain/entity/profile_entity.dart';

abstract class UserProfileRepository {
  Future<ProfileEntity?> getProfile(String userId);
  Future<void> updateProfile(ProfileEntity entity);
  Future<void> delete(String userId);
}
