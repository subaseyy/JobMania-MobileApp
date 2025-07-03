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
    emit(state.copyWith(isLoading: true));

    try {
      final response = await dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.login}',
        data: {'email': event.username, 'password': event.password},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final role = data['user']['role'];
        final token = data['token'];

        // Save token and role
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user_role', role);

        if (role == 'company' || role == 'admin') {
          emit(
            state.copyWith(
              isLoading: false,
              isSuccess: false,
              message: 'Please login via web for company/admin access',
            ),
          );
        } else {
          emit(state.copyWith(isLoading: false, isSuccess: true));
        }
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            message: 'Login failed',
          ),
        );
      }
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? 'Login error';
      emit(state.copyWith(isLoading: false, isSuccess: false, message: msg));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          message: e.toString(),
        ),
      );
    }
  }
}
