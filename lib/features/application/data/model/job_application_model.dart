import '../../domain/entity/job_application_entity.dart';

class JobApplicationModel {
  final String id;
  final String jobId;
  final String applicantId;
  final String profileId;
  final String resume;
  final String coverLetter;
  final String status;
  final String appliedAt;

  JobApplicationModel({
    required this.id,
    required this.jobId,
    required this.applicantId,
    required this.profileId,
    required this.resume,
    required this.coverLetter,
    required this.status,
    required this.appliedAt,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationModel(
      id: json['_id'] ?? '',
      jobId: json['job'] is Map ? json['job']['_id'] ?? '' : '',
      applicantId: json['applicant'] ?? '',
      profileId: json['profile'] ?? '',
      resume: json['resume'] ?? '',
      coverLetter: json['coverLetter'] ?? '',
      status: json['status'] ?? '',
      appliedAt: json['appliedAt'] ?? '',
    );
  }

  JobApplicationEntity toEntity() {
    return JobApplicationEntity(
      id: id,
      jobId: jobId,
      applicantId: applicantId,
      applicationId: id,
      resume: resume,
      coverLetter: coverLetter,
      status: status,
      appliedAt: appliedAt,
      createdAt: DateTime.tryParse(appliedAt) ?? DateTime.now(),
      userId: '', // not provided by API directly
    );
  }
}
