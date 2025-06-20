class AuthEntity {
  final String userId;
  final String fullName;
  final String email;
  final String token;
  final String role;

  AuthEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.token,
    required this.role,
  });
}
