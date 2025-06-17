import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String userId;
  final String email;
  final String token;
  final String role;

  const AuthEntity({
    required this.userId,
    required this.email,
    required this.token,
    required this.role,
  });

  @override
  List<Object?> get props => [userId, email, token, role];
}
