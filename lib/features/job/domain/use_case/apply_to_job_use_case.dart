import '../repository/job_repository.dart';

class ApplyToJobUseCase {
  final JobRepository repository;

  ApplyToJobUseCase(this.repository);

  Future<void> call(String jobId, Map<String, dynamic> formData) async {
    await repository.applyToJob(jobId, formData);
  }
}
