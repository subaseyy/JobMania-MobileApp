class ApiEndpoints {
  ApiEndpoints._();

  // Timeouts
  static const connectionTimeout = Duration(seconds: 1000);
  static const receiveTimeout = Duration(seconds: 1000);

  // For Android Emulator
  // static const String serverAddress = "http://10.0.2.2:5050";
  // For iOS Simulator
  static const String serverAddress = "http://localhost:5050";
  // static const String serverAddress = "https://api.jobmania.subas.info.np";

  static const String baseUrl = "$serverAddress/api/";
  static const String imageUrl = "$serverAddress";

  // Auth
  static const String login = "auth/login";
  static const String signup = "auth/signup";
  static const String verifyOtp = "auth/verify-otp";
  static const String logout = "auth/logout";
  static const String changePassword = "auth/change-password";
  static const String changeEmailWithOtp = "auth/change-email";
  static const String verifyOtpForEmail = "auth/verify-email-otp";
  static const String profile = "users/profile";
  static const String submitJobApplication = "jobApplications/apply";
  static const String allJobs = "jobs/jobs";
  static const String myjobs = "jobApplications/my-applications";
}
