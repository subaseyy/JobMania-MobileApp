import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                    children: const [
                      Text(
                        'Welcome Back!',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Subas Kandel',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/67955251?v=4', // Extracted direct image link
                    ),
                    radius: 24,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
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
              _sectionHeader('Featured Jobs'),
              const SizedBox(height: 16),
              _featuredJobCard(),
              const SizedBox(height: 32),
              _sectionHeader('Recommended Jobs'),
              const SizedBox(height: 16),
              Row(
                children: [
                  _recommendedJobCard(
                    color: Colors.pink[50]!,
                    icon: LucideIcons.dribbble,
                    title: 'UX Designer',
                    company: 'Dribbble',
                    salary: '\$80,000/y',
                  ),
                  const SizedBox(width: 16),
                  _recommendedJobCard(
                    color: Colors.blue[50]!,
                    icon: LucideIcons.facebook,
                    title: 'Sr Engineer',
                    company: 'Facebook',
                    salary: '\$96,000/y',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'More',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text("See all", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _featuredJobCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[800],
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
              _jobTag('Design'),
              SizedBox(width: 8),
              _jobTag('Full-Time'),
              SizedBox(width: 8),
              _jobTag('Junior'),
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
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(company, style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 8),
            Text(salary, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _jobTag extends StatelessWidget {
  final String text;
  const _jobTag(this.text);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.white24,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}
