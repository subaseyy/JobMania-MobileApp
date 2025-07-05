import 'package:jobmaniaapp/features/user/data/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:jobmaniaapp/features/user/data/model/profile_hive_model.dart';
import 'package:jobmaniaapp/features/user/domain/entity/profile_entity.dart';
import 'package:jobmaniaapp/features/user/domain/repository/user_profile_repository.dart';

class UserProfileRemoteRepositoryImpl implements UserProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  UserProfileRemoteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProfileEntity?> getProfile(String key) async {
    final model =
        await remoteDataSource.fetchProfile(); // returns ProfileHiveModel
    return model.toEntity(); // convert to ProfileEntity
  }

  @override
  Future<void> updateProfile(ProfileEntity profile) async {
    final model = ProfileHiveModel.fromEntity(profile);
    await remoteDataSource.updateProfile(model);
  }

  @override
  Future<void> delete(String key) async {
    // Implement if applicable, or throw
    throw UnimplementedError("Delete is not supported remotely.");
  }
}
