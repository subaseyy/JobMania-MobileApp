import 'package:equatable/equatable.dart';

class OtpVerificationState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  const OtpVerificationState({
    required this.isLoading,
    required this.isSuccess,
    required this.errorMessage,
  });

  factory OtpVerificationState.initial() => const OtpVerificationState(
    isLoading: false,
    isSuccess: false,
    errorMessage: '',
  );

  OtpVerificationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return OtpVerificationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
