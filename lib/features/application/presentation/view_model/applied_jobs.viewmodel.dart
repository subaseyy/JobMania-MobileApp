import 'package:flutter/material.dart';
import 'package:jobmaniaapp/features/application/presentation/view_model/applied_job_ui.model.dart';

import '../../domain/repository/job_application_repository.dart';
import '../../../job/domain/repository/job_repository.dart';

class AppliedJobsViewModel {
  final JobApplicationRepository applicationRepository;
  final JobRepository jobRepository;

  AppliedJobsViewModel(this.applicationRepository, this.jobRepository);

  List<AppliedJobUIModel> _appliedJobs = [];
  List<AppliedJobUIModel> get appliedJobs => List.unmodifiable(_appliedJobs);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Call this method to fetch applied jobs and their job details
  Future<void> fetchAppliedJobs() async {
    _isLoading = true;
    _errorMessage = null;

    print('Starting fetchAppliedJobs...');

    try {
      final applications = await applicationRepository.getMyJobApplications();
      print('Fetched applications count: ${applications.length}');

      final List<AppliedJobUIModel> combinedList = [];

      for (var app in applications) {
        try {
          final job = await jobRepository.getJobById(app.jobId);
          combinedList.add(AppliedJobUIModel(application: app, job: job));
        } catch (jobError) {
          print(
            'Failed to fetch job details for jobId ${app.jobId}: $jobError',
          );
        }
      }

      _appliedJobs = combinedList;
    } catch (error) {
      print('Error fetching applied jobs: $error');
      _appliedJobs = [];
      _errorMessage = 'Failed to load applied jobs';
    }

    _isLoading = false;

    print('Completed fetchAppliedJobs.');
  }
}
