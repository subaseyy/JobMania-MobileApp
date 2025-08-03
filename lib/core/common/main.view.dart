import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/app/service_locator/service_locator.dart';
import 'package:jobmaniaapp/features/application/domain/repository/job_application_repository.dart';
import 'package:jobmaniaapp/features/application/presentation/view/appliedJobs.view.dart';
import 'package:jobmaniaapp/features/application/presentation/view_model/applied_jobs_cubit.dart';
import 'package:jobmaniaapp/features/home/presentation/view_model/dashboard_view_model.dart';
import 'package:jobmaniaapp/features/job/domain/repository/job_repository.dart';
import 'package:jobmaniaapp/features/job/presentation/view/allJobs.view.dart';

import 'package:jobmaniaapp/features/user/presentation/view_model/profile_view_model.dart';

import '../../features/home/presentation/view/dashboard.view.dart';
import '../../features/user/presentation/view/profile.view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      BlocProvider(
        create: (_) => serviceLocator<DashboardViewModel>()..loadJobs(),
        child: const DashboardView(),
      ),
      const AllJobsView(),
      BlocProvider(
        create:
            (context) => AppliedJobsCubit(
              serviceLocator<JobApplicationRepository>(),
              serviceLocator<JobRepository>(),
            )..fetchAppliedJobs(),
        child: const AppliedJobsView(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<ProfileViewModel>(),
        child: const ProfileView(),
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
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
            icon: Icon(Icons.save),
            label: 'Applied Jobs',
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
