import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:jobmaniaapp/app/constants/api_endpoint.dart';
import 'otpVerification_state.dart';

class OtpVerificationViewModel extends Cubit<OtpVerificationState> {
  final Dio dio;

  OtpVerificationViewModel({required this.dio})
    : super(OtpVerificationState.initial());

  Future<void> verifyOtp(String email, String otp) async {
    emit(state.copyWith(isLoading: true, errorMessage: '', isSuccess: false));

    try {
      final res = await dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.verifyOtp}',
        data: {"email": email, "otp": otp},
      );

      if (res.statusCode == 200) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: 'Incorrect OTP'));
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Verification failed: $e',
        ),
      );
    }
  }
}
