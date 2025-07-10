import 'package:jobmaniaapp/features/user/domain/entity/profile_entity.dart';
import 'package:jobmaniaapp/features/user/domain/repository/user_profile_repository.dart';

class GetProfileUseCase {
  final UserProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<ProfileEntity?> call(String userId) {
    return repository.getProfile(userId);
  }
}
