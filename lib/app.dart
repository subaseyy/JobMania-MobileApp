import 'package:flutter/material.dart';
import 'package:jobmaniaapp/view/splash.view.dart';

class JobManiaApp extends StatelessWidget {
  const JobManiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashView());
  }
}
