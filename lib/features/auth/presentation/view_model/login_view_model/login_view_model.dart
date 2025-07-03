import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:jobmaniaapp/app/constants/api_endpoint.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final Dio dio;

  LoginViewModel({required this.dio}) : super(LoginState.initial()) {
    on<LoginWithEmailAndPasswordEvent>(_onLogin);
  }

  Future<void> _onLogin(
    LoginWithEmailAndPasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, message: '', isSuccess: false));

    try {
      final response = await dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.login}',
        data: {
          'email': event.username.trim(),
          'password': event.password.trim(),
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final token = data['token'];
        final user = data['user'];

        final String role = user['role'] ?? '';
        final String userId = user['id'] ?? '';
        final String email = user['email'] ?? '';

        // Restrict web-only roles
        if (role == 'admin' || role == 'company') {
          emit(
            state.copyWith(
              isLoading: false,
              isSuccess: false,
              message: 'Please login via web for company/admin access.',
            ),
          );
          return;
        }

        // Save to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user_id', userId);
        await prefs.setString('user_email', email);
        await prefs.setString('user_role', role);

        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            message: 'Login failed. Please try again.',
          ),
        );
      }
    } on DioException catch (e) {
      final msg =
          e.response?.data['message'] ?? 'Login error. Please try again.';
      emit(state.copyWith(isLoading: false, isSuccess: false, message: msg));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          message: 'Unexpected error: ${e.toString()}',
        ),
      );
    }
  }
}
