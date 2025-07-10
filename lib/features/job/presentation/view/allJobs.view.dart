import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jobmaniaapp/features/job/domain/entity/job_entity.dart';
import 'package:jobmaniaapp/features/job/domain/repository/job_repository_impl.dart';
import 'package:jobmaniaapp/features/job/domain/use_case/get_all_jobs_use_case.dart';
import 'package:jobmaniaapp/features/job/presentation/view/jobsdetails.view.dart';
import 'package:jobmaniaapp/features/job/presentation/view_model/job_view_model.dart';

class AllJobsView extends StatefulWidget {
  const AllJobsView({super.key});

  @override
  State<AllJobsView> createState() => _AllJobsViewState();
}

class _AllJobsViewState extends State<AllJobsView> {
  late final JobViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    final repository = JobRepositoryImpl(dio: dio);
    final useCase = GetAllJobsUseCase(repository);
    _viewModel = JobViewModel(getAllJobsUseCase: useCase);
    _viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Jobs')),
      body: ValueListenableBuilder<List<JobPostEntity>>(
        valueListenable: _viewModel.jobs,
        builder:
            (context, jobs, _) => ListView.builder(
              controller: _viewModel.scrollController,
              itemCount: jobs.length + 1,
              itemBuilder: (context, index) {
                if (index < jobs.length) {
                  final job = jobs[index];
                  return ListTile(
                    title: Text(job.title),
                    subtitle: Text('${job.company} • ${job.location}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JobDetailPage(job: job),
                        ),
                      );
                    },
                  );
                } else if (_viewModel.isLoadingMore) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
      ),
    );
  }
}
