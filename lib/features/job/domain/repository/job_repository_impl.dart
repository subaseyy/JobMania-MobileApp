import 'package:dio/dio.dart';
import 'package:jobmaniaapp/app/constants/api_endpoint.dart';
import 'package:jobmaniaapp/features/job/domain/entity/job_entity.dart';
import 'package:jobmaniaapp/features/job/domain/repository/job_repository.dart';

class JobRepositoryImpl implements JobRepository {
  final Dio dio;

  JobRepositoryImpl({required this.dio});

  @override
  Future<List<JobPostEntity>> getAllJobs({
    int page = 1,
    int limit = 10,
    String? search,
    Map<String, dynamic>? filters,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'limit': limit.toString(),
      if (search != null && search.isNotEmpty) 'search': search,
      if (filters != null) ...filters,
    };

    final res = await dio.get(
      '${ApiEndpoints.baseUrl}${ApiEndpoints.allJobs}',
      queryParameters: queryParams,
    );

    final data = res.data['data'] as List;

    return data.map((e) {
      final rawRequirements = e['requirements'];
      final requirements =
          (rawRequirements is List)
              ? rawRequirements.map((item) => item.toString()).toList()
              : <String>[];

      return JobPostEntity(
        jobId: e['_id'] ?? '',
        employerId: e['employer'] ?? '',
        title: e['title'] ?? '',
        company: e['company'] ?? '',
        description: e['description'] ?? '',
        location: e['location'] ?? '',
        type: e['type'] ?? '',
        salaryMin: (e['salaryMin'] as num?)?.toDouble(),
        salaryMax: (e['salaryMax'] as num?)?.toDouble(),
        currency: e['currency'] ?? '',
        requirements: requirements,
      );
    }).toList();
  }

  @override
  Future<void> applyToJob(String jobId, Map<String, dynamic> formData) async {
    final form = FormData.fromMap(formData);
    await dio.post(
      '${ApiEndpoints.baseUrl}/jobApplications/apply/$jobId',
      data: form,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
  }
}
