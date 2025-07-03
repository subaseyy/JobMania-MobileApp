import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jobmaniaapp/app/service_locator/service_locator.dart';
import 'package:jobmaniaapp/core/network/hive_services.dart';

import 'package:jobmaniaapp/features/auth/presentation/view/login.view.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  Future<void> _logout(BuildContext context) async {
    // 1. Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_id');
    await prefs.remove('user_email');
    await prefs.remove('user_role');
    await prefs.remove('fullName');

    // 2. Clear Hive Auth Data
    final hiveService = serviceLocator<HiveService>();
    final authList = await hiveService.getAllAuth();
    for (var auth in authList) {
      await hiveService.deleteAuth(auth.userId);
    }

    // 3. Navigate to Login
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => serviceLocator<LoginViewModel>(),
                child: const LoginView(),
              ),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("More Page: Profile, Settings, etc."),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }
}
