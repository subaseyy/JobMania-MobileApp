import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/app/service_locator/service_locator.dart';
import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:jobmaniaapp/features/auth/presentation/view/login.view.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jobmaniaapp/features/user/presentation/view_model/profile_view_model.dart';
import 'package:jobmaniaapp/features/user/domain/entity/profile_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool eduExpanded = false, expExpanded = false, portExpanded = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id') ?? '';

    context.read<ProfileViewModel>().loadProfile(userId);
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    final hiveService = serviceLocator<HiveService>();
    final authUsers = await hiveService.getAllAuth();
    for (var user in authUsers) {
      await hiveService.deleteAuth(user.userId);
    }

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder:
            (_) => BlocProvider(
              create: (_) => serviceLocator<LoginViewModel>(),
              child: const LoginView(),
            ),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: BlocBuilder<ProfileViewModel, ProfileEntity?>(
        builder: (context, profile) {
          if (profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(profile.fullName, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 16),

                _section(
                  "Education",
                  eduExpanded,
                  () {
                    setState(() => eduExpanded = !eduExpanded);
                  },
                  profile.education.map((e) => Text(e.degree)).toList(),
                ),

                _section(
                  "Experience",
                  expExpanded,
                  () {
                    setState(() => expExpanded = !expExpanded);
                  },
                  profile.experience.map((e) => Text(e.role)).toList(),
                ),

                _section(
                  "Portfolio",
                  portExpanded,
                  () {
                    setState(() => portExpanded = !portExpanded);
                  },
                  profile.portfolio.map((e) => Text(e.title)).toList(),
                ),

                const SizedBox(height: 32),
                ElevatedButton(onPressed: _logout, child: const Text("Logout")),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _section(
    String title,
    bool expanded,
    VoidCallback onTap,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(expanded ? Icons.expand_less : Icons.expand_more),
          onTap: onTap,
        ),
        if (expanded)
          ...children.map(
            (w) => Padding(padding: const EdgeInsets.only(left: 16), child: w),
          ),
        const Divider(),
      ],
    );
  }
}
