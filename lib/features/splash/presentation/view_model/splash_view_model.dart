import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/app/service_locator/service_locator.dart';
import 'package:jobmaniaapp/features/auth/presentation/view/login.view.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jobmaniaapp/features/home/presentation/view/main.view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel extends Cubit<void> {
  SplashViewModel() : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate splash delay

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (context.mounted) {
      if (token != null && token.isNotEmpty) {
        // Navigate to MainView if token exists
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainView()),
        );
      } else {
        // Navigate to LoginView if no token
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
