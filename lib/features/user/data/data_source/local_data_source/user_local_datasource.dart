import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:jobmaniaapp/features/user/data/model/profile_hive_model.dart';

class UserLocalDatasource {
  final HiveService hiveService;

  UserLocalDatasource({required this.hiveService});

  Future<ProfileHiveModel?> getProfile(String id) {
    return hiveService.getProfile(id);
  }

  Future<void> saveProfile(ProfileHiveModel profile) {
    return hiveService.saveProfile(profile);
  }
}
