import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmaniaapp/app/service_locator/service_locator.dart';
import 'package:jobmaniaapp/features/auth/presentation/view/login.view.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jobmaniaapp/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:jobmaniaapp/core/common/main.view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    Future.microtask(() {
      context.read<SplashViewModel>().init(
        onAuthenticated: () {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainView()),
          );
        },
        onLogin: () {
          if (!mounted) return;
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
        },
        onBiometricFailed: () {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Biometric authentication failed')),
          );

          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _blinkingDots() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        int dotCount = (3 * _controller.value).floor() + 1;
        return Text(
          '.' * dotCount,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF356899), // top
              Color(0xFF1A334C), // bottom
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  "assets/logo/splashscreenlogo.png",
                  width: 300,
                  height: 300,
                ),
              ),
              const SizedBox(height: 16),
              _blinkingDots(), 
            ],
          ),
        ),
      ),
    );
  }
}
