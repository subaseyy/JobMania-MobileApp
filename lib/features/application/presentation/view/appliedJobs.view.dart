import 'package:flutter/material.dart';

class AppliedJobsView extends StatelessWidget {
  const AppliedJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Applied Jobs")),
      body: const Center(child: Text("You haven’t applied any jobs yet.")),
    );
  }
}
