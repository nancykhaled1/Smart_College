import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:smart_college/Models/Request/ChangePasswordRequest.dart';
import 'package:smart_college/Models/Request/ResetPasswordRequest.dart';
import 'package:smart_college/Models/Response/ChangePaswwordResponse.dart';
import 'package:smart_college/Models/Response/ResetPasswordResponse.dart';
import '../../Models/Request/AlumniRegisterRequest.dart';
import '../../Models/Request/LoginRequest.dart';
import '../../Models/Request/SendEmailRequest.dart';
import '../../Models/Request/VerifyEmailRequest.dart';
import '../../Models/Request/studentRegisterRequest.dart';
import '../../Models/Response/GoogleResponse.dart';
import '../../Models/Response/LoginError.dart';
import '../../Models/Response/LoginResponse.dart';
import '../../Models/Response/SendEmailResponse.dart';
import '../../Models/Response/StudentRegisterResponse.dart';
import '../../Models/Response/VerifyEmailError.dart';
import '../../Models/Response/VerifyEmailResponse.dart';
import '../../Models/Response/registerError.dart';
import '../../Models/Response/NewsListResponse.dart';
import '../../Models/Response/NewsError.dart';
import '../../Models/Response/news_model.dart';
import 'apiConstants.dart';


class ApiManager {
  static const String baseUrl = "https://smartcollgeapp-production.up.railway.app/api"; // عدلي اللينك بتاع سيرفرك



  Future<Either<RegisterError, StudentRegisterResponse>> studentRegister(
      String name,
      String email,
      String password,
       String role,
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.studentRegisterApi);

        var requestBody = StudentRegisterRequest(
          email: email,
          password: password,
          name: name,
          role: role,
        );

        print('Sending request to: $url');
        print('Request body: ${requestBody.toJson()}');

        var response = await http.post(url, body: requestBody.toJson());

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var registerResponse = StudentRegisterResponse.fromJson(jsonResponse);
          return right(registerResponse);
        } else {
          // أخطاء السيرفر
          return left(RegisterError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
        return left(RegisterError(
          success: false,
          error: ErrorDetails(
            code: 0,
            message: "No Internet Connection",
           // details: "Please check your connection and try again.",
          ),
        ));
      }
    } catch (e) {
      print('Exception: $e');
      return left(RegisterError(
        success: false,
        error: ErrorDetails(
          code: -1,
          message: "Unexpected Error",
         // details: e.toString(),
        ),
      ));
    }
  }

   Future<Either<RegisterError, StudentRegisterResponse>> alumniRegister(
       AlumniRegisterRequest request,
       ) async {
     try {
       final connectivityResult = await Connectivity().checkConnectivity();

       if (connectivityResult == ConnectivityResult.mobile ||
           connectivityResult == ConnectivityResult.wifi) {
         Uri url =
         Uri.https(ApiConstants.baseurl, ApiConstants.studentRegisterApi);

         print('Sending Alumni Register request to: $url');
         print('Request body: ${request.toJson()}');

         var response = await http.post(
           url,
           body: jsonEncode(request.toJson()), // مهم هنا تستخدم jsonEncode
           headers: {
             "Content-Type": "application/json",
             "Accept": "application/json",
           },
         );

         print('Response status: ${response.statusCode}');
         print('Response body: ${response.body}');

         var jsonResponse = jsonDecode(response.body);

         if (response.statusCode >= 200 && response.statusCode < 300) {
           var registerResponse = StudentRegisterResponse.fromJson(jsonResponse);
           return right(registerResponse);
         } else {
           // أخطاء السيرفر
           return left(RegisterError.fromJson(jsonResponse));
         }
       } else {
         // مفيش انترنت
         return left(RegisterError(
           success: false,
           error: ErrorDetails(
             code: 0,
             message: "No Internet Connection",
           ),
         ));
       }
     } catch (e) {
       print('Exception: $e');
       return left(RegisterError(
         success: false,
         error: ErrorDetails(
           code: -1,
           message: "Unexpected Error",
         ),
       ));
     }
   }

   Future<Either<VerifyError, VerifyEmailResponse>> verifyEmail(
       VerifyEmailRequest request,
       ) async {
     try {
       final connectivityResult = await Connectivity().checkConnectivity();

       if (connectivityResult == ConnectivityResult.mobile ||
           connectivityResult == ConnectivityResult.wifi) {
         Uri url =
         Uri.https(ApiConstants.baseurl, ApiConstants.verifyEmailApi);

         print('Sending Verify Email request to: $url');
         print('Request body: ${request.toJson()}');

         var response = await http.post(
           url,
           body: jsonEncode(request.toJson()), // مهم هنا برضو jsonEncode
           headers: {
             "Content-Type": "application/json",
             "Accept": "application/json",
           },
         );

         print('Response status: ${response.statusCode}');
         print('Response body: ${response.body}');

         var jsonResponse = jsonDecode(response.body);
         if (response.statusCode >= 200 && response.statusCode < 300) {
           final verifyResponse = VerifyEmailResponse.fromJson(jsonResponse);
           return right(verifyResponse);
         }
 else {
           // أخطاء السيرفر
           return left(VerifyError.fromJson(jsonResponse));
         }
       } else {
         // مفيش انترنت
         return left(VerifyError(
          code: 0,
           message: 'No internet connection',
         ));
       }
     } catch (e) {
       print('Exception: $e');
       return left(VerifyError(
           code: -1,
           message: "Unexpected Error",

       ));
     }
   }

    Future<Either<LoginError, LoginResponse>> login(
       String email,
       String password
       ) async {
     try {
       final connectivityResult = await Connectivity().checkConnectivity();

       if (connectivityResult == ConnectivityResult.mobile ||
           connectivityResult == ConnectivityResult.wifi) {

         Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.LoginApi);

         var requestBody = LoginRequest(
          email: email,
          password: password,
         );

         print('Sending request to: $url');
         print('Request body: ${requestBody.toJson()}');

         var response = await http.post(
           url,
           headers: {'Content-Type': 'application/json'},
           body: jsonEncode(requestBody.toJson()), // تأكد toJson يرجع Map<String, dynamic>
         );


         print('Response status: ${response.statusCode}');
         print('Response body: ${response.body}');

         var jsonResponse = jsonDecode(response.body);

         if (response.statusCode >= 200 && response.statusCode < 300) {
           var registerResponse = LoginResponse.fromJson(jsonResponse);
           return right(registerResponse);
         }  else {
           // أخطاء السيرفر
           return left(LoginError.fromJson(jsonResponse));
         }
       } else {
         // مفيش انترنت
         return left(LoginError(
           success: false,
           error: LoginDetailsError(
             code: 0,
             message: "No Internet Connection",
           ),
         ));
       }
     } catch (e) {
       print('Exception: $e');
       return left(LoginError(
         success: false,
         error: LoginDetailsError(
           code: -1,
           message: "Unexpected Error",
         ),
       ));
     }




   }


   Future<Either<LoginError, SendEmailResponse>> sendEmail(
       String email,
       ) async {
     try {
       final connectivityResult = await Connectivity().checkConnectivity();

       if (connectivityResult == ConnectivityResult.mobile ||
           connectivityResult == ConnectivityResult.wifi) {

         Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.sendEmailApi);

         var requestBody = SendEmailRequest(
          email: email,
         );

         print('Sending request to: $url');
         print('Request body: ${requestBody.toJson()}');

         var response = await http.post(
           url,
           headers: {'Content-Type': 'application/json'},
           body: jsonEncode(requestBody.toJson()), // تأكد toJson يرجع Map<String, dynamic>
         );


         print('Response status: ${response.statusCode}');
         print('Response body: ${response.body}');

         var jsonResponse = jsonDecode(response.body);

         if (response.statusCode >= 200 && response.statusCode < 300) {
           var sendEmailResponse = SendEmailResponse.fromJson(jsonResponse);
           return right(sendEmailResponse);
         }  else {
           // أخطاء السيرفر
           return left(LoginError.fromJson(jsonResponse));
         }
       } else {
         // مفيش انترنت
         return left(LoginError(
           success: false,
           error: LoginDetailsError(
             code: 0,
             message: "No Internet Connection",
           ),
         ));
       }
     } catch (e) {
       print('Exception: $e');
       return left(LoginError(
         success: false,
         error: LoginDetailsError(
           code: -1,
           message: "Unexpected Error",
         ),
       ));
     }




   }



   Future<Either<VerifyError, ResetPasswordResponse>> resetPassword(
       ResetPasswordRequest request,
       ) async {
     try {
       final connectivityResult = await Connectivity().checkConnectivity();

       if (connectivityResult == ConnectivityResult.mobile ||
           connectivityResult == ConnectivityResult.wifi) {
         Uri url =
         Uri.https(ApiConstants.baseurl, ApiConstants.resetPassApi);

         print('Sending reset password request to: $url');
         print('Request body: ${request.toJson()}');

         var response = await http.post(
           url,
           body: jsonEncode(request.toJson()), // مهم هنا برضو jsonEncode
           headers: {
             "Content-Type": "application/json",
             "Accept": "application/json",
           },
         );

         print('Response status: ${response.statusCode}');
         print('Response body: ${response.body}');

         var jsonResponse = jsonDecode(response.body);
         if (response.statusCode >= 200 && response.statusCode < 300) {
           final resetPassResponse = ResetPasswordResponse.fromJson(jsonResponse);
           return right(resetPassResponse);
         }
         else {
           // أخطاء السيرفر
           return left(VerifyError.fromJson(jsonResponse));
         }
       } else {
         // مفيش انترنت
         return left(VerifyError(
           code: 0,
           message: 'No internet connection',
         ));
       }
     } catch (e) {
       print('Exception: $e');
       return left(VerifyError(
         code: -1,
         message: "Unexpected Error",

       ));
     }
   }

   Future<Either<LoginError, ChangePaswwordResponse>> changePassword(
       String email,
       String code,
       String newPassword
       ) async {
     try {
       final connectivityResult = await Connectivity().checkConnectivity();

       if (connectivityResult == ConnectivityResult.mobile ||
           connectivityResult == ConnectivityResult.wifi) {

         Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.changePassApi);

         var requestBody = ChangePasswordRequest(
          email: email,
          code: code,
          newPassword: newPassword
         );

         print('Sending request to: $url');
         print('Request body: ${requestBody.toJson()}');

         var response = await http.post(
           url,
           headers: {'Content-Type': 'application/json'},
           body: jsonEncode(requestBody.toJson()), // تأكد toJson يرجع Map<String, dynamic>
         );


         print('Response status: ${response.statusCode}');
         print('Response body: ${response.body}');

         var jsonResponse = jsonDecode(response.body);

         if (response.statusCode >= 200 && response.statusCode < 300) {
           var changePassResponse = ChangePaswwordResponse.fromJson(jsonResponse);
           return right(changePassResponse);
         }  else {
           // أخطاء السيرفر
           return left(LoginError.fromJson(jsonResponse));
         }
       } else {
         // مفيش انترنت
         return left(LoginError(
           success: false,
           error: LoginDetailsError(
             code: 0,
             message: "No Internet Connection",
           ),
         ));
       }
     } catch (e) {
       print('Exception: $e');
       return left(LoginError(
         success: false,
         error: LoginDetailsError(
           code: -1,
           message: "Unexpected Error",
         ),
       ));
     }




   }


  Future<Either<LoginError, GoogleResponse>> googleLogin(
      String token
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        // الـ endpoint لازم يحدد من الباك
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.googleLoginApi);

        var requestBody = {
          "token": token, // ده اللي جاي من GoogleSignIn
        };

        print('Sending Google Login request to: $url');
        print('Request body: $requestBody');

        var response = await http.post(
          url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(requestBody),
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var googleResponse = GoogleResponse.fromJson(jsonResponse);
          return right(googleResponse);
        } else {
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش إنترنت
        return left(LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ));
      }
    } catch (e) {
      print('Exception in Google Login: $e');
      return left(LoginError(
        success: false,
        error: LoginDetailsError(
          code: -1,
          message: "Unexpected Error",
        ),
      ));
    }
  }



















  // News API Methods

  Future<Either<NewsError, NewsListResponse>> getAllNews({
    int page = 1,
    int limit = 10,
    bool random = false,
  }) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        
        Map<String, String> queryParams = {
          'page': page.toString(), 
          'limit': limit.toString(),
        };
        
        // Add random parameter if requested
        if (random) {
          queryParams['random'] = 'true';
        }
        
        Uri url = Uri.https(
          ApiConstants.baseurl, 
          ApiConstants.getAllNewsApi,
          queryParams
        );

        print('Sending get all news request to: $url');

        var response = await http.get(
          url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var newsResponse = NewsListResponse.fromJson(jsonResponse);
          return right(newsResponse);
        } else {
          return left(NewsError.fromJson(jsonResponse));
        }
      } else {
        return left(NewsError(
          success: false,
          message: "No Internet Connection",
          code: 0,
        ));
      }
    } catch (e) {
      print('Exception in getAllNews: $e');
      return left(NewsError(
        success: false,
        message: "Unexpected Error",
        code: -1,
        details: e.toString(),
      ));
    }
  }

  Future<Either<NewsError, NewsModel>> getNewsById(String id) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        
        Uri url = Uri.https(
          ApiConstants.baseurl, 
          ApiConstants.getAllNewsApi,
          {'id': id}
        );

        print('Sending get news by id request to: $url');

        var response = await http.get(
          url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          // Handle the new JSON structure where data contains a "news" array
          NewsModel news;
          if (jsonResponse['data'] != null && jsonResponse['data']['news'] != null) {
            // New structure: data.news[0]
            var newsList = jsonResponse['data']['news'] as List<dynamic>?;
            if (newsList != null && newsList.isNotEmpty) {
              news = NewsModel.fromJson(newsList[0]);
            } else {
              return left(NewsError(
                success: false,
                message: "News not found",
                code: 404,
              ));
            }
          } else {
            // Fallback for old structure or direct news object
            news = NewsModel.fromJson(jsonResponse['data'] ?? jsonResponse);
          }
          return right(news);
        } else {
          return left(NewsError.fromJson(jsonResponse));
        }
      } else {
        return left(NewsError(
          success: false,
          message: "No Internet Connection",
          code: 0,
        ));
      }
    } catch (e) {
      print('Exception in getNewsById: $e');
      return left(NewsError(
        success: false,
        message: "Unexpected Error",
        code: -1,
        details: e.toString(),
      ));
    }
  }

  Future<Either<NewsError, NewsListResponse>> getLatestNews({
    int count = 3,
    bool random = true,
  }) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        
        Map<String, String> queryParams = {
          'count': count.toString(),
        };
        
        // Add random parameter if requested
        if (random) {
          queryParams['random'] = 'true';
        }
        
        Uri url = Uri.https(
          ApiConstants.baseurl, 
          ApiConstants.getAllNewsApi,
          queryParams
        );

        print('Sending get latest news request to: $url');

        var response = await http.get(
          url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var newsResponse = NewsListResponse.fromJson(jsonResponse);
          return right(newsResponse);
        } else {
          return left(NewsError.fromJson(jsonResponse));
        }
      } else {
        return left(NewsError(
          success: false,
          message: "No Internet Connection",
          code: 0,
        ));
      }
    } catch (e) {
      print('Exception in getLatestNews: $e');
      return left(NewsError(
        success: false,
        message: "Unexpected Error",
        code: -1,
        details: e.toString(),
      ));
    }
  }

  Future<Either<NewsError, NewsListResponse>> getImportantNews() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        
        Uri url = Uri.https(
          ApiConstants.baseurl, 
          ApiConstants.getAllNewsApi,
          {'important': 'true'}
        );

        print('Sending get important news request to: $url');

        var response = await http.get(
          url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var newsResponse = NewsListResponse.fromJson(jsonResponse);
          return right(newsResponse);
        } else {
          return left(NewsError.fromJson(jsonResponse));
        }
      } else {
        return left(NewsError(
          success: false,
          message: "No Internet Connection",
          code: 0,
        ));
      }
    } catch (e) {
      print('Exception in getImportantNews: $e');
      return left(NewsError(
        success: false,
        message: "Unexpected Error",
        code: -1,
        details: e.toString(),
      ));
    }
  }

  Future<Either<NewsError, NewsListResponse>> searchNews({
    String? query,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        
        Map<String, String> queryParams = {
          'page': page.toString(),
          'limit': limit.toString(),
        };
        
        if (query != null && query.isNotEmpty) {
          queryParams['query'] = query;
        }

        Uri url = Uri.https(
          ApiConstants.baseurl, 
          ApiConstants.getAllNewsApi,
          queryParams
        );

        print('Sending search news request to: $url');

        var response = await http.get(
          url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var newsResponse = NewsListResponse.fromJson(jsonResponse);
          return right(newsResponse);
        } else {
          return left(NewsError.fromJson(jsonResponse));
        }
      } else {
        return left(NewsError(
          success: false,
          message: "No Internet Connection",
          code: 0,
        ));
      }
    } catch (e) {
      print('Exception in searchNews: $e');
      return left(NewsError(
        success: false,
        message: "Unexpected Error",
        code: -1,
        details: e.toString(),
      ));
    }
  }



  // Get random news - dedicated method for random news
  Future<Either<NewsError, NewsListResponse>> getRandomNews({
    int count = 10,
  }) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        
        Uri url = Uri.https(
          ApiConstants.baseurl, 
          ApiConstants.getAllNewsApi,
          {'count': count.toString(), 'random': 'true'}
        );

        print('Sending get random news request to: $url');

        var response = await http.get(
          url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var newsResponse = NewsListResponse.fromJson(jsonResponse);
          return right(newsResponse);
        } else {
          return left(NewsError.fromJson(jsonResponse));
        }
      } else {
        return left(NewsError(
          success: false,
          message: "No Internet Connection",
          code: 0,
        ));
      }
    } catch (e) {
      print('Exception in getRandomNews: $e');
      return left(NewsError(
        success: false,
        message: "Unexpected Error",
        code: -1,
        details: e.toString(),
      ));
    }
  }

}


