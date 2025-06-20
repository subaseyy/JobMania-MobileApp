import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:jobmaniaapp/features/auth/domain/entity/auth_entity.dart';
import 'package:jobmaniaapp/features/auth/data/repository/local_repository/auth_repository.dart';
import 'package:jobmaniaapp/features/auth/data/model/auth_hive_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final HiveService hiveService;

  AuthRepositoryImpl({required this.hiveService});

  @override
  Future<void> register(AuthEntity entity) async {
    final model = AuthHiveModel.fromEntity(entity);
    await hiveService.registerAuth(model);
  }
}
