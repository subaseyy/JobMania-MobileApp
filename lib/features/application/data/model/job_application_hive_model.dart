import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:jobmaniaapp/core/constants/hive_table_constant.dart';
import 'package:jobmaniaapp/features/application/domain/entity/job_application_entity.dart';

part 'job_application_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.jobApplicationTableId)
class JobApplicationHiveModel extends Equatable {
  @HiveField(0)
  final String applicationId;

  @HiveField(1)
  final String jobId;

  @HiveField(2)
  final String applicantId;

  @HiveField(3)
  final String resume;

  @HiveField(4)
  final String coverLetter;

  @HiveField(5)
  final String status;

  @HiveField(6)
  final String appliedAt;

  JobApplicationHiveModel({
    String? applicationId,
    required this.jobId,
    required this.applicantId,
    required this.resume,
    required this.coverLetter,
    required this.status,
    required this.appliedAt,
  }) : applicationId = applicationId ?? const Uuid().v4();

  factory JobApplicationHiveModel.fromEntity(JobApplicationEntity entity) {
    return JobApplicationHiveModel(
      applicationId: entity.applicationId,
      jobId: entity.jobId,
      applicantId: entity.applicantId,
      resume: entity.resume,
      coverLetter: entity.coverLetter,
      status: entity.status,
      appliedAt: entity.appliedAt,
    );
  }

  JobApplicationEntity toEntity() {
    return JobApplicationEntity(
      applicationId: applicationId,
      jobId: jobId,
      applicantId: applicantId,
      resume: resume,
      coverLetter: coverLetter,
      status: status,
      appliedAt: appliedAt,
    );
  }

  @override
  List<Object?> get props => [
    applicationId,
    jobId,
    applicantId,
    resume,
    coverLetter,
    status,
    appliedAt,
  ];
}
