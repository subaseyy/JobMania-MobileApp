import 'package:flutter/material.dart';

class AllJobsView extends StatelessWidget {
  const AllJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Jobs")),
      body: const Center(child: Text("Your All Jobs will appear here.")),
    );
  }
}
