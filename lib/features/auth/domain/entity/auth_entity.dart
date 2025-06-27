class AuthEntity {
  final String userId;
  final String fullName;
  final String email;
  final String password;
  final String token;
  final String role;

  AuthEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.password,
    required this.token,
    required this.role,
  });
}
