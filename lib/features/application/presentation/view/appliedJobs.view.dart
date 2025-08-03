import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/features/application/presentation/view_model/applied_jobs_cubit.dart';

class AppliedJobsView extends StatelessWidget {
  const AppliedJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Applied Jobs")),
      body: BlocBuilder<AppliedJobsCubit, AppliedJobsState>(
        builder: (context, state) {
          if (state is AppliedJobsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AppliedJobsLoaded) {
            if (state.appliedJobs.isEmpty) {
              return const Center(
                child: Text("You haven’t applied to any jobs yet."),
              );
            }
            return ListView.builder(
              itemCount: state.appliedJobs.length,
              itemBuilder: (context, index) {
                final appliedJob = state.appliedJobs[index];
                final job = appliedJob.job;
                final application = appliedJob.application;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(job.title),
                    subtitle: Text('${job.company} • ${job.location}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          application.status,
                          style: TextStyle(
                            color:
                                application.status.toLowerCase() == 'accepted'
                                    ? Colors.green
                                    : application.status.toLowerCase() ==
                                        'rejected'
                                    ? Colors.red
                                    : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          application.appliedAt,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is AppliedJobsError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
