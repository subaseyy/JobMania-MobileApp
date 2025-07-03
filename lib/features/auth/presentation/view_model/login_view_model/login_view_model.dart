import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:jobmaniaapp/features/auth/data/model/auth_hive_model.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:jobmaniaapp/app/constants/api_endpoint.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final Dio dio;
  final HiveService hiveService;

  LoginViewModel({required this.dio, required this.hiveService})
    : super(LoginState.initial()) {
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
        final String token = data['token'] ?? '';
        final Map<String, dynamic> user = data['user'] ?? {};

        final String role = user['role'] ?? '';
        final String userId = user['id'] ?? '';
        final String email = user['email'] ?? '';
        final String fullName = user['name'] ?? '';

        // 🚫 Prevent login for admin/company from mobile
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

        // 🐝 Save to Hive
        final authHiveModel = AuthHiveModel(
          userId: userId,
          fullName: fullName,
          email: email,
          password: event.password,
          token: token,
          role: role,
        );

        await hiveService.clearAuth();
        await hiveService.registerAuth(authHiveModel);

        // 💾 Save to SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user_id', userId);
        await prefs.setString('user_email', email);
        await prefs.setString('user_role', role);
        await prefs.setString('fullName', fullName);

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
