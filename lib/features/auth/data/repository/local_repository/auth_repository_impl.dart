import 'package:jobmaniaapp/core/constants/hive_table_constant.dart';
import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:jobmaniaapp/features/auth/data/model/auth_hive_model.dart';
import 'package:jobmaniaapp/features/auth/data/repository/local_repository/auth_repository.dart';
import 'package:jobmaniaapp/features/auth/domain/entity/auth_entity.dart';

class AuthLocalRepository implements AuthRepository {
  final HiveService hiveService;

  AuthLocalRepository({required this.hiveService});

  @override
  Future<void> register(AuthEntity entity) async {
    final box = await hiveService.openBox<AuthHiveModel>(
      HiveTableConstant.authBox,
    );

    final model = AuthHiveModel.fromEntity(entity);
    await box.put(model.userId, model);
  }
}
