import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/features/home/presentation/view/main.view.dart';
import 'package:jobmaniaapp/features/auth/presentation/view/login.view.dart';
import 'package:jobmaniaapp/app/service_locator/service_locator.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jobmaniaapp/features/splash/presentation/view_model/biometric_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel extends Cubit<void> {
  SplashViewModel() : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (context.mounted) {
      if (token != null && token.isNotEmpty) {
        // 🔐 Biometric check
        final auth = BiometricHelper();
        final isAuthenticated = await auth.authenticate();

        if (isAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainView()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Biometric authentication failed')),
          );

          // Exit the app
          if (Platform.isAndroid) {
            SystemNavigator.pop(); // Android
          } else if (Platform.isIOS) {
            exit(0); // iOS
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
