import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:jobmaniaapp/core/constants/hive_table_constant.dart';
import 'package:jobmaniaapp/features/auth/domain/entity/auth_entity.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.authTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String token;

  @HiveField(4)
  final String password;

  @HiveField(5)
  final String role;

  AuthHiveModel({
    String? userId,
    required this.fullName,
    required this.email,
    required this.password,
    required this.token,
    required this.role,
  }) : userId = userId ?? const Uuid().v4();

  const AuthHiveModel.initial()
    : userId = '',
      fullName = '',
      email = '',
      password = '',
      token = '',
      role = '';

  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password,
      token: entity.token,
      role: entity.role,
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      password: password,
      token: token,
      role: role,
    );
  }

  @override
  List<Object?> get props => [userId, fullName, email, password, token, role];
}
