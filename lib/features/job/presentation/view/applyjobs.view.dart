import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ApplyJobForm extends StatefulWidget {
  final String jobId;
  const ApplyJobForm({super.key, required this.jobId});

  @override
  State<ApplyJobForm> createState() => _ApplyJobFormState();
}

class _ApplyJobFormState extends State<ApplyJobForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController currentTitle = TextEditingController();
  final TextEditingController linkedin = TextEditingController();
  final TextEditingController portfolio = TextEditingController();
  final TextEditingController additionalInfo = TextEditingController();

  XFile? resumeFile;

  Future<void> _submitApplication() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Upload logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: fullName,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: phone,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextFormField(
              controller: currentTitle,
              decoration: const InputDecoration(labelText: 'Current Title'),
            ),
            TextFormField(
              controller: linkedin,
              decoration: const InputDecoration(labelText: 'LinkedIn URL'),
            ),
            TextFormField(
              controller: portfolio,
              decoration: const InputDecoration(labelText: 'Portfolio URL'),
            ),
            TextFormField(
              controller: additionalInfo,
              decoration: const InputDecoration(labelText: 'Additional Info'),
            ),
            ElevatedButton(
              onPressed: _submitApplication,
              child: const Text("Submit Application"),
            ),
          ],
        ),
      ),
    );
  }
}
