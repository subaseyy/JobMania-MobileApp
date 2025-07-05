import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jobmaniaapp/features/splash/presentation/view_model/biometric_helper.dart';

class SplashViewModel extends Cubit<void> {
  final HiveService hiveService;

  SplashViewModel({required this.hiveService}) : super(null);

  Future<void> init({
    required Function onAuthenticated,
    required Function onLogin,
    required Function onBiometricFailed,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate loading

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final userId = prefs.getString('user_id');
    final authUsers = await hiveService.getAllAuth();

    if (token != null && userId != null && authUsers.isNotEmpty) {
      final biometricHelper = BiometricHelper();
      final isAuthenticated = await biometricHelper.authenticate();

      if (isAuthenticated) {
        onAuthenticated();
      } else {
        onBiometricFailed();
      }
    } else {
      onLogin();
    }
  }
}
