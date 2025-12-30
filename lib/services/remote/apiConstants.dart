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
static const String NewsApi = "/api/user/news";
static String newsByIdApi(String id) => '/api/user/news/$id';

 static String lectureByIdApi(String id) => '/api/user/lecture/$id';

 static const String lecturesApi = "/api/user/lecture";









}

