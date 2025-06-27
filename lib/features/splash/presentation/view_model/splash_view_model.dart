import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/app/service_locator/service_locator.dart';
import 'package:jobmaniaapp/features/auth/presentation/view/login.view.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:jobmaniaapp/features/home/presentation/view/main.view.dart';

class SplashViewModel extends Cubit<void> {
  final HiveService hiveService;

  SplashViewModel({required this.hiveService}) : super(null);

  Future<void> init(BuildContext context) async {
    final authList = await hiveService.getAllAuth();
    final isLoggedIn = authList.isNotEmpty;

    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => serviceLocator<LoginViewModel>(),
                child: const LoginView(),
              ),
        ),
      );
    }
  }
}
