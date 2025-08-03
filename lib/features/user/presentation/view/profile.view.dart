import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/app/service_locator/service_locator.dart';
import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:jobmaniaapp/features/auth/presentation/view/login.view.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jobmaniaapp/features/user/domain/entity/education_entity.dart';
import 'package:jobmaniaapp/features/user/domain/entity/experience_entity.dart';
import 'package:jobmaniaapp/features/user/domain/entity/portfolio_entity.dart';
import 'package:jobmaniaapp/features/user/domain/entity/profile_entity.dart';
import 'package:jobmaniaapp/features/user/presentation/view_model/profile_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool eduExpanded = false, expExpanded = false, portExpanded = false;
  bool isEditing = false;

  // Initialize controllers immediately to avoid LateInitializationError
  final TextEditingController titleController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController profilePictureController =
      TextEditingController();
  final TextEditingController bgImageController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();

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

  void _toggleEdit(ProfileEntity profile) {
    setState(() {
      if (!isEditing) {
        // Populate controllers with current profile data for editing
        titleController.text = profile.title;

        locationController.text = profile.location;
        companyController.text = profile.company;
        profilePictureController.text = profile.profilePicture;
        bgImageController.text = profile.bgImage;
        skillsController.text = profile.skills.join(', ');
      } else {
        // On save, update the profile entity and call update method
        final updated = ProfileEntityCopyWith(profile).copyWith(
          title: titleController.text,

          location: locationController.text,
          company: companyController.text,
          profilePicture: profilePictureController.text,
          bgImage: bgImageController.text,
          skills:
              skillsController.text.split(',').map((s) => s.trim()).toList(),
        );
        context.read<ProfileViewModel>().updateProfile(updated);
      }
      isEditing = !isEditing;
    });
  }

  @override
  void dispose() {
    titleController.dispose();

    locationController.dispose();
    companyController.dispose();
    profilePictureController.dispose();
    bgImageController.dispose();
    skillsController.dispose();
    super.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.fullName, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 16),
                _infoField("Title", profile.title, controller: titleController),
                _infoField(
                  "Company",
                  profile.company,
                  controller: companyController,
                ),
                _infoField(
                  "Location",
                  profile.location,
                  controller: locationController,
                ),

                _infoField(
                  "Skills",
                  profile.skills.join(', '),
                  controller: skillsController,
                ),
                const SizedBox(height: 24),
                // _section(
                //   "Education",
                //   eduExpanded,
                //   () => setState(() => eduExpanded = !eduExpanded),
                //   profile.education.map((e) => Text(e.degree)).toList(),
                // ),
                _section(
                  "Education",
                  eduExpanded,
                  () => setState(() => eduExpanded = !eduExpanded),
                  profile.education.map((e) => Text(e.degree)).toList(),
                ),
                _section(
                  "Experience",
                  expExpanded,
                  () => setState(() => expExpanded = !expExpanded),
                  profile.experience.map((e) => Text(e.role)).toList(),
                ),
                _section(
                  "Portfolio",
                  portExpanded,
                  () => setState(() => portExpanded = !portExpanded),
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

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _infoField(
    String label,
    String value, {
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child:
          isEditing
              ? TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  border: const OutlineInputBorder(),
                ),
              )
              : _infoRow(label, value),
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

extension ProfileEntityCopyWith on ProfileEntity {
  ProfileEntity copyWith({
    String? fullName,
    String? title,
    String? company,
    String? location,
    String? phone,
    String? profilePicture,
    String? bgImage,
    List<String>? skills,
    List<EducationEntity>? education,
    List<ExperienceEntity>? experience,
    List<PortfolioEntity>? portfolio,
    String? email,
    String? about,
    String? languages,
    String? instagram,
    String? twitter,
    String? website,
    String? createdAt,
    String? updatedAt,
  }) {
    return ProfileEntity(
      userId: this.userId,
      fullName: fullName ?? this.fullName,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,

      profilePicture: profilePicture ?? this.profilePicture,
      bgImage: bgImage ?? this.bgImage,
      skills: skills ?? this.skills,
      education: education ?? this.education,
      experience: experience ?? this.experience,
      portfolio: portfolio ?? this.portfolio,
      email: email ?? this.email,
      about: about ?? this.about,
      languages: languages ?? this.languages,
      instagram: instagram ?? this.instagram,
      twitter: twitter ?? this.twitter,
      website: website ?? this.website,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      phone: '',
    );
  }
}
