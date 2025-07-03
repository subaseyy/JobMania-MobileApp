import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/app/service_locator/service_locator.dart';
import 'package:jobmaniaapp/core/network/hive_services.dart';

import 'package:jobmaniaapp/features/auth/presentation/view/login.view.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jobmaniaapp/core/common/main.view.dart';
import 'package:jobmaniaapp/features/splash/presentation/view_model/biometric_helper.dart';

class SplashViewModel extends Cubit<void> {
  final HiveService hiveService;

  SplashViewModel({required this.hiveService}) : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2)); // Optional splash delay

    final authUsers = await hiveService.getAllAuth();

    if (context.mounted) {
      if (authUsers.isNotEmpty) {
        final biometricHelper = BiometricHelper();
        final isAuthenticated = await biometricHelper.authenticate();

        if (isAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainView()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Biometric authentication failed')),
          );

          // Exit the app if biometric fails
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }
      } else {
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
}
