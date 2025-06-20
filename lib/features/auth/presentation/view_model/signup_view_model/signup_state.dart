import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  const SignupState({
    required this.isLoading,
    required this.isSuccess,
    required this.errorMessage,
  });

  factory SignupState.initial() {
    return const SignupState(
      isLoading: false,
      isSuccess: false,
      errorMessage: '',
    );
  }

  SignupState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
