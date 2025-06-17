import 'package:jobmaniaapp/features/user/data/data_source/local_data_source/user_local_datasource.dart';
import 'package:jobmaniaapp/features/user/domain/entity/profile_entity.dart';
import 'package:jobmaniaapp/features/user/domain/repository/user_profile_repository.dart';

import 'package:jobmaniaapp/features/user/data/model/profile_hive_model.dart';

class UserLocalRepository implements UserProfileRepository {
  final UserLocalDatasource datasource;

  UserLocalRepository({required this.datasource});

  @override
  Future<ProfileEntity?> getProfile(String id) async {
    final profile = await datasource.getProfile(id);
    return profile?.toEntity();
  }

  @override
  Future<void> updateProfile(ProfileEntity entity) {
    final model = ProfileHiveModel.fromEntity(entity);
    return datasource.saveProfile(model);
  }
}
