import 'package:flutter/material.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved Jobs")),
      body: const Center(
        child: Text("You haven’t saved any jobs yet."),
      ),
    );
  }
}
