import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:jobmaniaapp/core/constants/hive_table_constant.dart';
import 'package:jobmaniaapp/features/job/domain/entity/job_entity.dart';

part 'job_post_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.jobPostTableId)
class JobPostHiveModel extends Equatable {
  @HiveField(0)
  final String jobId;

  @HiveField(1)
  final String employerId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String company;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String location;

  @HiveField(6)
  final String type;

  @HiveField(7)
  final double? salaryMin;

  @HiveField(8)
  final double? salaryMax;

  @HiveField(9)
  final String currency;

  @HiveField(10)
  final List<String> requirements;

  JobPostHiveModel({
    String? jobId,
    required this.employerId,
    required this.title,
    required this.company,
    required this.description,
    required this.location,
    required this.type,
    this.salaryMin,
    this.salaryMax,
    required this.currency,
    required this.requirements,
  }) : jobId = jobId ?? const Uuid().v4();

  const JobPostHiveModel.initial()
    : jobId = '',
      employerId = '',
      title = '',
      company = '',
      description = '',
      location = '',
      type = '',
      salaryMin = null,
      salaryMax = null,
      currency = 'USD',
      requirements = const [];

  factory JobPostHiveModel.fromEntity(JobPostEntity entity) {
    return JobPostHiveModel(
      jobId: entity.jobId,
      employerId: entity.employerId,
      title: entity.title,
      company: entity.company,
      description: entity.description,
      location: entity.location,
      type: entity.type,
      salaryMin: entity.salaryMin,
      salaryMax: entity.salaryMax,
      currency: entity.currency,
      requirements: entity.requirements,
    );
  }

  JobPostEntity toEntity() {
    return JobPostEntity(
      jobId: jobId,
      employerId: employerId,
      title: title,
      company: company,
      description: description,
      location: location,
      type: type,
      salaryMin: salaryMin,
      salaryMax: salaryMax,
      currency: currency,
      requirements: requirements,
    );
  }

  @override
  List<Object?> get props => [
    jobId,
    employerId,
    title,
    company,
    description,
    location,
    type,
    salaryMin,
    salaryMax,
    currency,
    requirements,
  ];
}
