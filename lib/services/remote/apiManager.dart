import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:smart_college/Models/Request/ChangePasswordRequest.dart';
import 'package:smart_college/Models/Request/ResetPasswordRequest.dart';
import 'package:smart_college/Models/Response/ChangePaswwordResponse.dart';
import 'package:smart_college/Models/Response/ResetPasswordResponse.dart';
import 'package:smart_college/Models/Response/newsModel.dart';
import 'package:smart_college/Models/Response/subject_model.dart';
import 'package:smart_college/services/local/sharedPreference.dart';
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

  // lecture api //////////////////////////


  Future<Either<LoginError, LectureResponseModel>> getLectures() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.lecturesApi);
        print('📡 Fetching lectures from: $url');
        
        final savedToken = await TokenStorage.getToken();
        
        if (savedToken == null || savedToken.isEmpty) {
          print("⚠️ No auth token found. User needs to login first.");
          return left(
            LoginError(
              success: false,
              error: LoginDetailsError(
                code: 401,
                message: "يرجى تسجيل الدخول أولاً",
              ),
            ),
          );
        }
        
        print('✅ Token found: ${savedToken.substring(0, 20)}...');
        
        var response = await http.get(
          url,
          headers: {
            "Authorization": "Bearer $savedToken",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );
        
        print('📥 Lectures API Response status: ${response.statusCode}');
        print('📥 Lectures API Response body: ${response.body}');
        
        var jsonResponse = jsonDecode(response.body);
        
        if (response.statusCode >= 200 && response.statusCode < 300) {
          var lectureResponse = LectureResponseModel.fromJson(jsonResponse);
          print('✅ Lectures fetched successfully: ${lectureResponse.data.length} lectures');
          return right(lectureResponse);
        } else {
          print('❌ Lectures API Error: ${jsonResponse.toString()}');
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 0,
              message: "No Internet Connection",
            ),
          ),
        );
      }
    } catch (e) {
      print('❌ Exception in getLectures: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: -1,
            message: "حدث خطأ غير متوقع: ${e.toString()}",
          ),
        ),
      );
    }
  }

  // Get Lecture By ID
  Future<Either<LoginError, LectureDetailResponse>> getLectureById(String lectureId) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.lectureByIdApi(lectureId));
        print('📡 Fetching lecture details from: $url');
        
        final savedToken = await TokenStorage.getToken();
        
        if (savedToken == null || savedToken.isEmpty) {
          print("⚠️ No auth token found. User needs to login first.");
          return left(
            LoginError(
              success: false,
              error: LoginDetailsError(
                code: 401,
                message: "يرجى تسجيل الدخول أولاً",
              ),
            ),
          );
        }
        
        print('✅ Token found: ${savedToken.substring(0, 20)}...');
        
        var response = await http.get(
          url,
          headers: {
            "Authorization": "Bearer $savedToken",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );
        
        print('📥 Lecture details API Response status: ${response.statusCode}');
        print('📥 Lecture details API Response body: ${response.body}');
        
        var jsonResponse = jsonDecode(response.body);
        
        if (response.statusCode >= 200 && response.statusCode < 300) {
          var lectureDetailResponse = LectureDetailResponse.fromJson(jsonResponse);
          print('✅ Lecture details fetched successfully');
          return right(lectureDetailResponse);
        } else {
          print('❌ Lecture details API Error: ${jsonResponse.toString()}');
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 0,
              message: "No Internet Connection",
            ),
          ),
        );
      }
    } catch (e) {
      print('❌ Exception in getLectureById: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: -1,
            message: "حدث خطأ غير متوقع: ${e.toString()}",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, NewsResponse>> getNews() async {
    try {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {

      Uri url = Uri.https(
        ApiConstants.baseurl,
        ApiConstants.NewsApi,
      );

      print('📡 Fetching news from: $url');

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null || savedToken.isEmpty) {
        print("⚠️ No auth token found. User needs to login first.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "يرجى تسجيل الدخول أولاً",
            ),
          ),
        );
      }

      print('✅ Token found: ${savedToken.substring(0, 20)}...');

      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $savedToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('📥 News API Response status: ${response.statusCode}');
      print('📥 News API Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var newsResponse = NewsResponse.fromJson(jsonResponse);
        print('✅ News fetched successfully: ${newsResponse.data.length} news items');
        return right(newsResponse);
      } else {
        print('❌ News API Error: ${jsonResponse.toString()}');
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  } catch (e) {
    print('❌ Exception in getNews: $e');
    return left(
      LoginError(
        success: false,
        error: LoginDetailsError(
          code: -1,
          message: "حدث خطأ غير متوقع: ${e.toString()}",
        ),
      ),
    );
    
  }

  // Get News By ID
 
}

 Future<Either<LoginError, NewsDetailResponse>> getNewsById(String newsId) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.newsByIdApi(newsId));
        print('📡 Fetching news details from: $url');
        
        final savedToken = await TokenStorage.getToken();
        
        if (savedToken == null || savedToken.isEmpty) {
          print("⚠️ No auth token found. User needs to login first.");
          return left(
            LoginError(
              success: false,
              error: LoginDetailsError(
                code: 401,
                message: "يرجى تسجيل الدخول أولاً",
              ),
            ),
          );
        }
        
        print('✅ Token found: ${savedToken.substring(0, 20)}...');
        
        var response = await http.get(
          url,
          headers: {
            "Authorization": "Bearer $savedToken",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );
        
        print('📥 News details API Response status: ${response.statusCode}');
        print('📥 News details API Response body: ${response.body}');
        
        var jsonResponse = jsonDecode(response.body);
        
        if (response.statusCode >= 200 && response.statusCode < 300) {
          var newsDetailResponse = NewsDetailResponse.fromJson(jsonResponse);
          print('✅ News details fetched successfully');
          return right(newsDetailResponse);
        } else {
          print('❌ News details API Error: ${jsonResponse.toString()}');
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 0,
              message: "No Internet Connection",
            ),
          ),
        );
      }
    } catch (e) {
      print('❌ Exception in getNewsById: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: -1,
            message: "حدث خطأ غير متوقع: ${e.toString()}",
          ),
        ),
      );
    }
  } 
     













}


  /////////////////////////
 
