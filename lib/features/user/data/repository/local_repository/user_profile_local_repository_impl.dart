import 'package:jobmaniaapp/features/user/data/data_source/local_data_source/profile_local_datasource.dart';
import 'package:jobmaniaapp/features/user/data/model/profile_hive_model.dart';
import 'package:jobmaniaapp/features/user/domain/entity/profile_entity.dart';
import 'package:jobmaniaapp/features/user/domain/repository/user_profile_repository.dart';

class UserProfileLocalRepositoryImpl implements UserProfileRepository {
  final ProfileLocalDataSource localDataSource;

  UserProfileLocalRepositoryImpl({required this.localDataSource});

  @override
  Future<ProfileEntity?> getProfile(String key) async {
    final model = await localDataSource.getProfile(key);
    return model?.toEntity(); // Make sure toEntity exists on ProfileHiveModel
  }

  @override
  Future<void> updateProfile(ProfileEntity profile) async {
    final model = ProfileHiveModel.fromEntity(profile); // Make sure this exists
    await localDataSource.saveProfile(model);
  }

  @override
  Future<void> delete(String key) async {
    await localDataSource.deleteProfile(key);
  }
}
