import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobmaniaapp/core/constants/hive_table_constant.dart';
import 'package:jobmaniaapp/features/auth/data/model/auth_hive_model.dart';
import 'package:jobmaniaapp/features/auth/domain/use_case/register_usecase.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/signup_view_model/signup_state.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entity/auth_entity.dart';
import 'package:jobmaniaapp/core/network/hive_services.dart';

class SignupViewModel extends Cubit<SignupState> {
  final RegisterUseCase useCase;
  final HiveService hiveService;

  SignupViewModel({required this.useCase, required this.hiveService})
    : super(SignupState.initial());

  Future<void> register(
    String email,
    String fullName,
    String password,
    String role,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: '', isSuccess: false));

    final existingUsers = await hiveService.getAllAuth();
    final isDuplicate = existingUsers.any((user) => user.email == email);

    if (isDuplicate) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Email is already registered.',
          isSuccess: false,
        ),
      );
      return;
    }

    final entity = AuthEntity(
      userId: const Uuid().v4(),
      email: email,
      password: password,
      token: generateMockToken(),
      role: role,
      fullName: fullName,
    );

    final box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    final all = box.values.toList();

    for (var user in all) {
      print("Email: ${user.email}, Password: ${user.password}");
    }

    await useCase.execute(entity);

    emit(state.copyWith(isLoading: false, errorMessage: '', isSuccess: true));
  }
}

String generateMockToken() {
  var uuid = Uuid();
  return 'user_${uuid.v4()}';
}
