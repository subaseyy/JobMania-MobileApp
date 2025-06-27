import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:jobmaniaapp/features/auth/data/model/auth_hive_model.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_state.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final HiveService hiveService;

  LoginViewModel({required this.hiveService})
    : super(const LoginState.initial()) {
    on<LoginWithEmailAndPasswordEvent>(_onLoginWithEmailAndPassword);
  }

  Future<void> _onLoginWithEmailAndPassword(
    LoginWithEmailAndPasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final String username = event.username.trim();
      final String password = event.password.trim();

      if (username.isEmpty || password.isEmpty) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        return;
      }

      final users = await hiveService.getAllAuth();

      // Debug log: check what's in the box
      print('Attempting login with: $username / $password');
      for (var u in users) {
        print('Existing user: ${u.email} / ${u.password}');
      }

      final user = users.firstWhere(
        (u) => u.email.trim() == username && u.password.trim() == password,
        orElse: () => AuthHiveModel.initial(),
      );

      final isMatch = user.userId.isNotEmpty;

      emit(state.copyWith(isLoading: false, isSuccess: isMatch));
    } catch (e) {
      print('Login error: $e');
      emit(state.copyWith(isLoading: false, isSuccess: false));
    }
  }
}
