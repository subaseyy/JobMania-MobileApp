import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/features/job/domain/entity/job_entity.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:jobmaniaapp/features/home/presentation/view_model/dashboard_view_model.dart';
import 'package:jobmaniaapp/features/home/presentation/view_model/dashboard_state.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardViewModel, DashboardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error.isNotEmpty) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              children: [
                const SizedBox(height: 24),
                _header(),
                const SizedBox(height: 24),
                _searchBar(context),
                const SizedBox(height: 32),
                _sectionHeader(context, 'Featured Jobs'),
                const SizedBox(height: 16),
                if (state.jobs.isNotEmpty)
                  _featuredJobCard(context, state.jobs.first)
                else
                  const Text('No jobs available.'),
                const SizedBox(height: 32),
                _sectionHeader(context, 'Recommended Jobs'),
                const SizedBox(height: 16),
                _recommendedJobsRow(context, state.jobs),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              'Subas Kandel',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/67955251?v=4',
          ),
        ),
      ],
    );
  }

  Widget _searchBar(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: "Search a job or position",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const Text("See all", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _featuredJobCard(BuildContext context, JobPostEntity job) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.business, color: Colors.blue),
              ),
              const SizedBox(width: 10),
              Text(
                job.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(Icons.bookmark_border, color: Colors.white),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _JobTag(job.type),
              const SizedBox(width: 8),
              _JobTag(job.location),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${job.currency} ${job.salaryMin?.toStringAsFixed(0) ?? '—'} - ${job.salaryMax?.toStringAsFixed(0) ?? '—'}',
                style: const TextStyle(color: Colors.white),
              ),
              Text(job.company, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _recommendedJobsRow(BuildContext context, List<JobPostEntity> jobs) {
    final theme = Theme.of(context);
    final displayedJobs = jobs.skip(1).take(2).toList();

    return Row(
      children:
          displayedJobs.map((job) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    const Icon(LucideIcons.briefcase, size: 36),
                    const SizedBox(height: 12),
                    Text(job.title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      job.company,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${job.currency} ${job.salaryMin?.toStringAsFixed(0) ?? '—'}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}

class _JobTag extends StatelessWidget {
  final String text;
  const _JobTag(this.text);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.white24,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}
