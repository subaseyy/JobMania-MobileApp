import 'package:flutter/material.dart';
import '../../domain/use_case/apply_to_job_use_case.dart';

class ApplyJobViewModel extends ChangeNotifier {
  final ApplyToJobUseCase applyToJobUseCase;
  bool isSubmitting = false;

  ApplyJobViewModel({required this.applyToJobUseCase});

  Future<void> submitApplication(
    String jobId,
    Map<String, dynamic> formData,
  ) async {
    isSubmitting = true;
    notifyListeners();

    try {
      await applyToJobUseCase(jobId, formData);
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
