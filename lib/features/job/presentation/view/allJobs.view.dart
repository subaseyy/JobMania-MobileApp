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
  bool _isInitializing = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeViewModel();
  }

  Future<void> _initializeViewModel() async {
    try {
      final dio = Dio();
      final repository = JobRepositoryImpl(dio);
      final useCase = GetAllJobsUseCase(repository);
      _viewModel = JobViewModel(getAllJobsUseCase: useCase);

      _viewModel.init();

      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load jobs: ${e.toString()}';
          _isInitializing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Jobs'),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isInitializing) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading jobs...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _error = null;
                  _isInitializing = true;
                });
                _initializeViewModel();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return ValueListenableBuilder<List<JobPostEntity>>(
      valueListenable: _viewModel.jobs,
      builder: (context, jobs, _) {
        if (jobs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.work_off, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No jobs available',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            _viewModel.refresh();
          },
          child: ListView.builder(
            controller: _viewModel.scrollController,
            itemCount: jobs.length + 1,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              if (index < jobs.length) {
                final job = jobs[index];
                return _buildJobCard(job);
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
        );
      },
    );
  }

  Widget _buildJobCard(JobPostEntity job) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            job.company.isNotEmpty ? job.company[0].toUpperCase() : 'J',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          job.title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.business, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    job.company,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    job.location,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => JobDetailPage(job: job)),
          );

          // Handle any result from the detail page if needed
          if (result != null) {
            // Handle navigation result
          }
        },
      ),
    );
  }
}
