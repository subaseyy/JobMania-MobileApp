import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:jobmaniaapp/features/job/presentation/view_model/apply_job_view_model.dart';

class ApplyJobForm extends StatefulWidget {
  final String jobId;
  // final ApplyJobViewModel applyJobViewModel;
  const ApplyJobForm({super.key, required this.jobId});

  @override
  State<ApplyJobForm> createState() => _ApplyJobFormState();
}

class _ApplyJobFormState extends State<ApplyJobForm>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController currentTitle = TextEditingController();
  final TextEditingController linkedin = TextEditingController();
  final TextEditingController portfolio = TextEditingController();
  final TextEditingController additionalInfo = TextEditingController();

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late final ApplyJobViewModel applyJobViewModel;

  PlatformFile? resumeFile;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    fullName.dispose();
    email.dispose();
    phone.dispose();
    currentTitle.dispose();
    linkedin.dispose();
    portfolio.dispose();
    additionalInfo.dispose();
    super.dispose();
  }

  Future<void> _pickResume() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.single;

        // Check file size (max 5MB)
        if (file.size > 5 * 1024 * 1024) {
          _showSnackBar('File size must be less than 5MB', isError: true);
          return;
        }

        setState(() {
          resumeFile = file;
        });
        HapticFeedback.lightImpact();
      }
    } catch (e) {
      _showSnackBar('Error picking file: $e', isError: true);
    }
  }

  Future<void> _submitApplication() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      _showSnackBar('Please fill in all required fields', isError: true);
      return;
    }

    if (resumeFile == null) {
      _showSnackBar('Please upload your resume', isError: true);
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    HapticFeedback.mediumImpact();

    try {
      final File file = File(resumeFile!.path!);
      final bytes = await file.readAsBytes();
      final base64Resume = base64Encode(bytes);

      final formData = {
        'full_name': fullName.text.trim(),
        'email': email.text.trim(),
        'phone': phone.text.trim(),
        'current_title': currentTitle.text.trim(),
        'linkedin': linkedin.text.trim(),
        'portfolio': portfolio.text.trim(),
        'additional_info': additionalInfo.text.trim(),
        'resume_base64': base64Resume,
        'resume_filename': resumeFile!.name,
      };

      print('Submit button pressed');

      await applyJobViewModel.submitApplication(widget.jobId, formData);

      print('Submitted successfully');

      if (mounted) {
        _showSuccessDialog(); // Only show success if no exception
      }
    } catch (e) {
      print('Error during submit: $e');
      if (mounted) {
        _showSnackBar(
          'Failed to submit application. Please try again.',
          isError: true,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.all(24),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 64,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Application Submitted!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Thank you for your application. We\'ll review it and get back to you soon.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF64748B),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pop(); // Close form
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStepIndicator(),
                        const SizedBox(height: 32),
                        _buildPersonalInfoSection(),
                        const SizedBox(height: 32),
                        _buildProfessionalInfoSection(),
                        const SizedBox(height: 32),
                        _buildResumeSection(),
                        const SizedBox(height: 32),
                        _buildAdditionalInfoSection(),
                        const SizedBox(height: 40),
                        _buildSubmitButton(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.work_rounded,
                  color: Color(0xFF3B82F6),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apply for Position',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Fill out the form below to submit your application',
                      style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded),
                style: IconButton.styleFrom(backgroundColor: Colors.grey[100]),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3B82F6).withOpacity(0.1),
            const Color(0xFF8B5CF6).withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline_rounded, color: Color(0xFF3B82F6), size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Complete all sections to submit your application',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return _buildSection('Personal Information', Icons.person_outline_rounded, [
      _buildTextField(
        controller: fullName,
        label: 'Full Name',
        icon: Icons.person_rounded,
        validator:
            (value) =>
                value?.trim().isEmpty ?? true ? 'Full name is required' : null,
      ),
      const SizedBox(height: 20),
      _buildTextField(
        controller: email,
        label: 'Email Address',
        icon: Icons.email_rounded,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value?.trim().isEmpty ?? true) return 'Email is required';
          if (!RegExp(
            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
          ).hasMatch(value!.trim())) {
            return 'Enter a valid email';
          }
          return null;
        },
      ),
      const SizedBox(height: 20),
      _buildTextField(
        controller: phone,
        label: 'Phone Number',
        icon: Icons.phone_rounded,
        keyboardType: TextInputType.phone,
        validator:
            (value) =>
                value?.trim().isEmpty ?? true
                    ? 'Phone number is required'
                    : null,
      ),
    ]);
  }

  Widget _buildProfessionalInfoSection() {
    return _buildSection(
      'Professional Information',
      Icons.work_outline_rounded,
      [
        _buildTextField(
          controller: currentTitle,
          label: 'Current Job Title',
          icon: Icons.badge_rounded,
          validator:
              (value) =>
                  value?.trim().isEmpty ?? true
                      ? 'Current title is required'
                      : null,
        ),
        const SizedBox(height: 20),
        _buildTextField(
          controller: linkedin,
          label: 'LinkedIn Profile (Optional)',
          icon: Icons.link_rounded,
          keyboardType: TextInputType.url,
          validator: (value) {
            if (value?.trim().isNotEmpty ?? false) {
              if (!Uri.tryParse(value!.trim())!.hasAbsolutePath ?? true) {
                return 'Enter a valid URL';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildTextField(
          controller: portfolio,
          label: 'Portfolio/Website (Optional)',
          icon: Icons.web_rounded,
          keyboardType: TextInputType.url,
          validator: (value) {
            if (value?.trim().isNotEmpty ?? false) {
              if (!Uri.tryParse(value!.trim())!.hasAbsolutePath ?? true) {
                return 'Enter a valid URL';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildResumeSection() {
    return _buildSection('Resume/CV', Icons.description_outlined, [
      Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                resumeFile != null
                    ? const Color(0xFF10B981)
                    : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _pickResume,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          resumeFile != null
                              ? const Color(0xFF10B981).withOpacity(0.1)
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      resumeFile != null
                          ? Icons.check_circle
                          : Icons.cloud_upload_rounded,
                      size: 32,
                      color:
                          resumeFile != null
                              ? const Color(0xFF10B981)
                              : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    resumeFile != null
                        ? 'Resume Selected'
                        : 'Upload Your Resume',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          resumeFile != null
                              ? const Color(0xFF10B981)
                              : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    resumeFile != null
                        ? '${resumeFile!.name} (${_formatFileSize(resumeFile!.size)})'
                        : 'PDF, DOC, or DOCX (Max 5MB)',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  if (resumeFile != null) ...[
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: _pickResume,
                      icon: const Icon(Icons.refresh_rounded, size: 16),
                      label: const Text('Change File'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF3B82F6),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _buildAdditionalInfoSection() {
    return _buildSection('Additional Information', Icons.notes_rounded, [
      _buildTextField(
        controller: additionalInfo,
        label: 'Cover Letter / Additional Notes (Optional)',
        icon: Icons.description_rounded,
        maxLines: 5,
        hint: 'Tell us why you\'re interested in this position...',
      ),
    ]);
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: const Color(0xFF3B82F6), size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(fontSize: 16, color: Color(0xFF1E293B)),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF64748B)),
        labelStyle: const TextStyle(
          color: Color(0xFF64748B),
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _submitApplication,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: _isSubmitting ? 0 : 8,
          shadowColor: const Color(0xFF3B82F6).withOpacity(0.4),
        ),
        child:
            _isSubmitting
                ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Submitting Application...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
                : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send_rounded, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Submit Application',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
