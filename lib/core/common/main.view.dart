import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/app/service_locator/service_locator.dart';
import 'package:jobmaniaapp/features/application/presentation/view/appliedJobs.view.dart';
import 'package:jobmaniaapp/features/home/presentation/view_model/dashboard_view_model.dart';
import 'package:jobmaniaapp/features/job/presentation/view/allJobs.view.dart';
import 'package:jobmaniaapp/features/saved_jobs/presentation/view/saved.view.dart';
import '../../features/home/presentation/view/dashboard.view.dart';

import '../../features/user/presentation/view/profile.view.dart'; // You'll create this below

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BlocProvider(
      create: (_) => serviceLocator<DashboardViewModel>()..loadJobs(),
      child: const DashboardView(),
    ),
    const AllJobsView(),
    const AppliedJobsView(),
    const SavedView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge_sharp),
            label: 'All Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge_rounded),
            label: 'Applied Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: 'Saved',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
