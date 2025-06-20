import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/features/auth/domain/use_case/register_usecase.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entity/auth_entity.dart';

class SignupViewModel extends Cubit<bool> {
  final RegisterUseCase useCase;

  SignupViewModel({required this.useCase}) : super(false);

  Future<void> register(
    String email,
    String fullName,
    String password,
    String role,
  ) async {
    final entity = AuthEntity(
      userId: const Uuid().v4(),
      email: email,
      token: 'mock_token', // Replace with actual logic if needed
      role: role,
      fullName: fullName,
    );

    await useCase.execute(entity);
    emit(true); // For navigation or success UI
  }
}
