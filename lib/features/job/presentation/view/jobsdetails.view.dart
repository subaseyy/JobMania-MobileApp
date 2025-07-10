import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobmaniaapp/features/job/domain/entity/job_entity.dart';
import 'package:jobmaniaapp/features/job/presentation/view/applyjobs.view.dart';

class JobDetailPage extends StatelessWidget {
  final JobPostEntity job;

  const JobDetailPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(job.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.company, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(job.description),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => ApplyJobForm(jobId: job.jobId),
                );
              },
              child: const Text('Apply to Job'),
            ),
          ],
        ),
      ),
    );
  }
}
