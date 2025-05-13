import 'package:flutter/material.dart';
import 'package:jobmaniaapp/view/login.view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    });

    return Scaffold(
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
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            child: Image.asset(
              "assets/logo/splashscreenlogo.png",
              width: 300, // Adjust the width to make the logo smaller
              height: 300, // Adjust the height if needed
            ),
          ),
        ),
      ),
    );
  }
}
