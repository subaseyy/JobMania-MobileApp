import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:jobmaniaapp/core/constants/hive_table_constant.dart';
import 'package:jobmaniaapp/features/user/domain/entity/education_entity.dart';

part 'education_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.educationTableId)
class EducationHiveModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String university;

  @HiveField(2)
  final String degree;

  @HiveField(3)
  final String duration;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String logo;

  EducationHiveModel({
    String? id,
    required this.university,
    required this.degree,
    required this.duration,
    required this.description,
    required this.logo,
  }) : id = id ?? const Uuid().v4();

  const EducationHiveModel.initial()
    : id = '',
      university = '',
      degree = '',
      duration = '',
      description = '',
      logo = '';

  factory EducationHiveModel.fromEntity(EducationEntity entity) {
    return EducationHiveModel(
      id: entity.id,
      university: entity.university,
      degree: entity.degree,
      duration: entity.duration,
      description: entity.description,
      logo: entity.logo,
    );
  }

  EducationEntity toEntity() {
    return EducationEntity(
      id: id,
      university: university,
      degree: degree,
      duration: duration,
      description: description,
      logo: logo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "university": university,
      "degree": degree,
      "duration": duration,
      "description": description,
      "logo": logo,
    };
  }

  @override
  List<Object?> get props => [
    id,
    university,
    degree,
    duration,
    description,
    logo,
  ];
}
