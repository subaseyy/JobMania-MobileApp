class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final String message;

  const LoginState({
    required this.isLoading,
    required this.isSuccess,
    required this.message,
  });

  factory LoginState.initial() {
    return const LoginState(isLoading: false, isSuccess: false, message: '');
  }

  LoginState copyWith({bool? isLoading, bool? isSuccess, String? message}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }
}
