import '../entity/job_entity.dart';
import '../repository/job_repository.dart';

class GetAllJobsUseCase {
  final JobRepository repository;

  GetAllJobsUseCase(this.repository);

  Future<List<JobPostEntity>> call({
    int page = 1,
    int limit = 10,
    String? search,
    Map<String, dynamic>? filters,
  }) async {
    return await repository.getAllJobs(
      page: page,
      limit: limit,
      search: search,
      filters: filters,
    );
  }
}
