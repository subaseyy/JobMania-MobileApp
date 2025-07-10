// data/data_source/local_data_source/profile_local_datasource.dart

import 'package:hive/hive.dart';
import 'package:jobmaniaapp/features/user/data/model/profile_hive_model.dart';

class ProfileLocalDataSource {
  static const String boxName = 'profileBox';

  Future<void> saveProfile(ProfileHiveModel model) async {
    final box = await Hive.openBox<ProfileHiveModel>(boxName);
    await box.put(model.userId, model);
  }

  Future<ProfileHiveModel?> getProfile(String userId) async {
    final box = await Hive.openBox<ProfileHiveModel>(boxName);
    return box.get(userId);
  }

  Future<void> deleteProfile(String userId) async {
    final box = await Hive.openBox<ProfileHiveModel>(boxName);
    await box.delete(userId);
  }

  Future<void> clear() async {
    final box = await Hive.openBox<ProfileHiveModel>(boxName);
    await box.clear();
  }
}
