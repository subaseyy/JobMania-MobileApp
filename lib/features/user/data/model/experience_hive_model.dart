import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:jobmaniaapp/core/constants/hive_table_constant.dart';
import 'package:jobmaniaapp/features/user/domain/entity/experience_entity.dart';

part 'experience_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.experienceTableId)
class ExperienceHiveModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String company;

  @HiveField(2)
  final String role;

  @HiveField(3)
  final String type;

  @HiveField(4)
  final String location;

  @HiveField(5)
  final String duration;

  @HiveField(6)
  final String period;

  @HiveField(7)
  final String description;

  @HiveField(8)
  final String logo;

  ExperienceHiveModel({
    String? id,
    required this.company,
    required this.role,
    required this.type,
    required this.location,
    required this.duration,
    required this.period,
    required this.description,
    required this.logo,
  }) : id = id ?? const Uuid().v4();

  const ExperienceHiveModel.initial()
    : id = '',
      company = '',
      role = '',
      type = '',
      location = '',
      duration = '',
      period = '',
      description = '',
      logo = '';

  factory ExperienceHiveModel.fromEntity(ExperienceEntity entity) {
    return ExperienceHiveModel(
      id: entity.id,
      company: entity.company,
      role: entity.role,
      type: entity.type,
      location: entity.location,
      duration: entity.duration,
      period: entity.period,
      description: entity.description,
      logo: entity.logo,
    );
  }

  ExperienceEntity toEntity() {
    return ExperienceEntity(
      id: id,
      company: company,
      role: role,
      type: type,
      location: location,
      duration: duration,
      period: period,
      description: description,
      logo: logo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "company": company,
      "role": role,
      "type": type,
      "location": location,
      "duration": duration,
      "period": period,
      "description": description,
      "logo": logo,
    };
  }

  @override
  List<Object?> get props => [
    id,
    company,
    role,
    type,
    location,
    duration,
    period,
    description,
    logo,
  ];
}
