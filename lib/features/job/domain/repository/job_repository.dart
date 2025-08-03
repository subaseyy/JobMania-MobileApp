import '../entity/job_entity.dart';

abstract class JobRepository {
  Future<List<JobPostEntity>> getAllJobs({
    int page,
    int limit,
    String? search,
    Map<String, dynamic>? filters,
  });

  Future<void> applyToJob(String jobId, Map<String, dynamic> formData);
  Future<JobPostEntity> getJobById(String jobId);
}
