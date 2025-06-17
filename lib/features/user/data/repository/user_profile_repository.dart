import 'package:jobmaniaapp/features/auth/domain/entity/auth_entity.dart';

abstract class UserProfileRepository {
  Future<List<AuthEntity>> getAllAuth();
  Future<void> register(AuthEntity entity);
  Future<void> delete(String userId);
}
