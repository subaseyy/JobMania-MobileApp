import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/features/job/domain/entity/job_entity.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jobmaniaapp/features/home/presentation/view_model/dashboard_view_model.dart';
import 'package:jobmaniaapp/features/home/presentation/view_model/dashboard_state.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String fullName = 'User';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadFullName();
  }

  Future<void> _loadFullName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('fullName') ?? 'User';
    });
  }

  List<JobPostEntity> _filterJobs(List<JobPostEntity> jobs) {
    if (_searchQuery.isEmpty) return jobs;

    return jobs.where((job) {
      final q = _searchQuery.toLowerCase();
      return job.title.toLowerCase().contains(q) ||
          job.company.toLowerCase().contains(q) ||
          job.location.toLowerCase().contains(q);
    }).toList();
  }

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

        final filteredJobs = _filterJobs(state.jobs);

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(fullName),
                const SizedBox(height: 24),
                _searchBar(),
                const SizedBox(height: 32),
                _sectionHeader(context, 'Browse by Category'),
                const SizedBox(height: 16),
                _categoryRow(),
                const SizedBox(height: 32),
                _sectionHeader(context, 'Featured Jobs'),
                const SizedBox(height: 16),
                if (filteredJobs.isNotEmpty)
                  _featuredJobCard(context, filteredJobs.first)
                else
                  const Text('No matching jobs found.'),
                const SizedBox(height: 32),
                _sectionHeader(context, 'Recommended Jobs'),
                const SizedBox(height: 16),
                _recommendedJobsRow(context, filteredJobs),
                const SizedBox(height: 32),
                _sectionHeader(context, 'Popular Companies'),
                const SizedBox(height: 16),
                _popularCompaniesRow(),
                const SizedBox(height: 48),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _header(String fullName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              fullName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/67955251?v=4',
          ),
        ),
      ],
    );
  }

  Widget _searchBar() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          icon: Icon(Icons.search),
          hintText: "Search a job or position",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
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

    if (jobs.isEmpty) {
      return const Text('No recommended jobs found.');
    }

    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: jobs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final job = jobs[index];
          return Container(
            width: 220,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const Spacer(),
                Text(
                  '${job.currency} ${job.salaryMin?.toStringAsFixed(0) ?? '—'}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _categoryRow() {
    final categories = [
      'Design',
      'Development',
      'Marketing',
      'Sales',
      'Human Resources',
    ];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Chip(
            label: Text(categories[index]),
            backgroundColor: Colors.grey[200],
          );
        },
      ),
    );
  }

  Widget _popularCompaniesRow() {
    final companies = [
      {'name': 'Google', 'logo': LucideIcons.globe},
      {'name': 'Meta', 'logo': LucideIcons.facebook},
      {'name': 'Netflix', 'logo': LucideIcons.tv},
      {'name': 'Apple', 'logo': LucideIcons.apple},
      {'name': 'Netlify', 'logo': LucideIcons.network},
      {'name': 'Spotify', 'logo': LucideIcons.music},
      {'name': 'Youtube', 'logo': LucideIcons.youtube},
      {'name': 'Maps', 'logo': LucideIcons.navigation},
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: companies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final item = companies[index];
          return Container(
            width: 100,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item['logo'] as IconData, size: 32),
                const SizedBox(height: 8),
                Text(
                  item['name'] as String,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
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
