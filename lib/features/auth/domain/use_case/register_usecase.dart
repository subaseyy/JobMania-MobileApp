import '../../data/repository/local_repository/auth_repository.dart';
import '../entity/auth_entity.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<void> execute(AuthEntity entity) async {
    await repository.register(entity);
  }
}
