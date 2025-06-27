import '../../../domain/entity/auth_entity.dart';

abstract class AuthRepository {
  Future<void> register(AuthEntity entity);
}
