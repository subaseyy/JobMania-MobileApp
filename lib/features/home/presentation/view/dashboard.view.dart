import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Subas Kandel',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/67955251?v=4',
                  ),
                  radius: 24,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
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
            ),
            const SizedBox(height: 32),
            _sectionHeader(context, 'Featured Jobs'),
            const SizedBox(height: 16),
            _featuredJobCard(theme),
            const SizedBox(height: 32),
            _sectionHeader(context, 'Recommended Jobs'),
            const SizedBox(height: 16),
            Row(
              children: [
                _recommendedJobCard(
                  color: Colors.pink[50]!,
                  icon: LucideIcons.dribbble,
                  title: 'UX Designer',
                  company: 'Dribbble',
                  salary: '\$80,000/y',
                  theme: theme,
                ),
                const SizedBox(width: 16),
                _recommendedJobCard(
                  color: Colors.blue[50]!,
                  icon: LucideIcons.facebook,
                  title: 'Sr Engineer',
                  company: 'Facebook',
                  salary: '\$96,000/y',
                  theme: theme,
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
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

  Widget _featuredJobCard(ThemeData theme) {
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
            children: const [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.g_translate, color: Colors.blue),
              ),
              SizedBox(width: 10),
              Text(
                'Product Designer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.bookmark_border, color: Colors.white),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              _JobTag('Design'),
              SizedBox(width: 8),
              _JobTag('Full-Time'),
              SizedBox(width: 8),
              _JobTag('Junior'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('\$160,000/year', style: TextStyle(color: Colors.white)),
              Text('California, USA', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _recommendedJobCard({
    required Color color,
    required IconData icon,
    required String title,
    required String company,
    required String salary,
    required ThemeData theme,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Icon(icon, size: 36),
            const SizedBox(height: 12),
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              company,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              salary,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
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
