import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:jobmaniaapp/app/constants/api_endpoint.dart';
import 'signup_state.dart';

class SignupViewModel extends Cubit<SignupState> {
  final Dio dio;

  SignupViewModel({required this.dio}) : super(SignupState.initial());

  Future<void> register(
    String email,
    String fullName,
    String password,
    String role,
  ) async {
    if (!isClosed) {
      emit(state.copyWith(isLoading: true, errorMessage: '', isSuccess: false));
    }

    try {
      final response = await dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.signup}',
        data: {
          "email": email,
          "full_name": fullName,
          "password": password,
          "role": role,
        },
      );

      if (!isClosed) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: 'Unexpected error: ${response.statusCode}',
              isSuccess: false,
            ),
          );
        }
      }
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final errorMessage =
          responseData is Map<String, dynamic> &&
                  responseData.containsKey('message')
              ? responseData['message'].toString()
              : 'Something went wrong during signup.';

      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: errorMessage,
            isSuccess: false,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Unexpected error: $e',
            isSuccess: false,
          ),
        );
      }
    }
  }
}
