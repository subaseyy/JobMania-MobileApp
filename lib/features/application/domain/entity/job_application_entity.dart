import 'package:equatable/equatable.dart';

class JobApplicationEntity extends Equatable {
  final String applicationId;
  final String jobId;
  final String applicantId;
  final String resume;
  final String coverLetter;
  final String status; // applied, shortlisted, interview, rejected, hired
  final String appliedAt;

  const JobApplicationEntity({
    required this.applicationId,
    required this.jobId,
    required this.applicantId,
    required this.resume,
    required this.coverLetter,
    required this.status,
    required this.appliedAt,
  });

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
