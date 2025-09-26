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
  static const String getNewsByIdApi = "/api/user/news/";
  static const String getLatestNewsApi = "/api/user/news/latest";
  static const String getImportantNewsApi = "/api/user/news/important";
  static const String searchNewsApi = "/api/user/news/search";
  static const String getNewsByCategoryApi = "/api/user/news/category/";
  static const String getNewsCategoriesApi = "/api/user/news/categories";








}

