class ApiConstants{

  static const String baseurl = "smartcollgeapp-production.up.railway.app";

  static const String studentRegisterApi = "/api/user/auth/local/signup";

  static const String alumniRegisterApi = "/api/user/auth/local/complete";

  static const String verifyEmailApi = "/api/user/auth/local/verify-email";

  static const String LoginApi = "/api/user/auth/local/login";

  static const String sendEmailApi = "/api/user/auth/local/forgot-password";

  static const String resetPassApi = "/api/user/auth/local/verify-code";

  static const String changePassApi = "/api/user/auth/local/reset-password";

  static const String googleLoginApi = "/api/user/auth/google";

  // News API endpoints
  static const String getAllNewsApi = "/api/user/news";
  
 

  static const String notificationApi = "/api/user/auth/local/fcm-token";

  static const String getNotificationApi = "/api/user/notification";

  static const String counterApi = "/api/user/notification/unread-count";

  static const String sendMessageApi = "/api/user/chat/messages/send";

  static const String completeProfileApi = "/api/user/auth/local/complete-student";

  static const String examsApi = "/api/user/exam/exams";

  static const String attemptApi = "/api/user/exam/attempt/start";

  static const String saveAnsApi = "/api/user/exam/attempt/save-answer";

  static const String submitApi = "/api/user/exam/attempt/submit";

  static const String myAttemptApi = "/api/user/exam/attempts";

  static const String profileApi = "/api/user/auth/local/profile";

  static const String updateDataApi = "/api/user/auth/local/update";

  static const String updateImageApi = "/api/user/auth/local/update-image";

  static const String deleteApi = "/api/user/auth/local/delete";

  static const String levelApi = "/api/user/level";

  static const String departmentApi = "/api/user/department";






  static const String getMessagesApi = "/api/user/chat/messages";




















}

