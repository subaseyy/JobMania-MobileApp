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
  final String email;

  @HiveField(2)
  final String token;

  @HiveField(3)
  final String role; // jobseeker / employer / admin

  AuthHiveModel({
    String? userId,
    required this.email,
    required this.token,
    required this.role,
  }) : userId = userId ?? const Uuid().v4();

  // Initial default constructor
  const AuthHiveModel.initial()
    : userId = '',
      email = '',
      token = '',
      role = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      email: entity.email,
      token: entity.token,
      role: entity.role,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(userId: userId, email: email, token: token, role: role);
  }

  @override
  List<Object?> get props => [userId, email, token, role];
}
