import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobmaniaapp/features/application/presentation/view_model/applied_job_ui.model.dart';
import 'package:jobmaniaapp/features/job/domain/entity/job_entity.dart';

import '../../domain/repository/job_application_repository.dart';
import '../../../job/domain/repository/job_repository.dart';

part 'applied_jobs_state.dart';

class AppliedJobsCubit extends Cubit<AppliedJobsState> {
  final JobApplicationRepository applicationRepository;
  final JobRepository jobRepository;

  List<JobPostEntity> _allJobs = [];

  AppliedJobsCubit(this.applicationRepository, this.jobRepository)
    : super(AppliedJobsInitial());

  // Fetch all jobs once and cache them locally
  Future<void> fetchAllJobs() async {
    try {
      _allJobs = await jobRepository.getAllJobs(limit: 100);
    } catch (e) {
      // Optionally handle error here or log it
      _allJobs = [];
    }
  }

  Future<void> fetchAppliedJobs() async {
    emit(AppliedJobsLoading());

    try {
      // Make sure all jobs are loaded first
      if (_allJobs.isEmpty) {
        await fetchAllJobs();
      }

      final applications = await applicationRepository.getMyJobApplications();

      final List<AppliedJobUIModel> combinedList = [];

      for (var app in applications) {
        // Find the matching job from the cached list
        final job = _allJobs.firstWhere(
          (job) => job.jobId == app.jobId,
          orElse:
              () => JobPostEntity(
                jobId: '',
                employerId: '',
                title: 'Unknown Job',
                company: '',
                description: '',
                location: '',
                type: '',
                salaryMin: null,
                salaryMax: null,
                currency: '',
                requirements: [],
              ),
        );

        combinedList.add(AppliedJobUIModel(application: app, job: job));
      }

      emit(AppliedJobsLoaded(appliedJobs: combinedList));
    } catch (error, stackTrace) {
      print('🔴 Error in fetchAppliedJobs: $error');
      print(stackTrace);
      emit(const AppliedJobsError(message: 'Failed to load applied jobs.'));
    }
  }
}
