import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:smart_college/Models/Request/ChangePasswordRequest.dart';
import 'package:smart_college/Models/Request/CompleteProfileRequest.dart';
import 'package:smart_college/Models/Request/ResetPasswordRequest.dart';
import 'package:smart_college/Models/Response/AllMessagesResponse.dart';
import 'package:smart_college/Models/Response/ChangePaswwordResponse.dart';
import 'package:smart_college/Models/Response/CompleteProfileResponse.dart';
import 'package:smart_college/Models/Response/CounterResponse.dart';
import 'package:smart_college/Models/Response/ExamsResponse.dart';
import 'package:smart_college/Models/Response/ResetPasswordResponse.dart';
import '../../Models/Request/AlumniRegisterRequest.dart';
import '../../Models/Request/LoginRequest.dart';
import '../../Models/Request/NotificationRequest.dart';
import '../../Models/Request/SendEmailRequest.dart';
import '../../Models/Request/VerifyEmailRequest.dart';
import '../../Models/Request/studentRegisterRequest.dart';
import '../../Models/Response/ExamDetailsResponse.dart';
import '../../Models/Response/GetNotificationResponse.dart';
import '../../Models/Response/GoogleResponse.dart';
import '../../Models/Response/LoginError.dart';
import '../../Models/Response/LoginResponse.dart';
import '../../Models/Response/NotificationDetailsResponse.dart';
import '../../Models/Response/NotificationResponse.dart';
import '../../Models/Response/SendEmailResponse.dart';
import '../../Models/Response/StudentRegisterResponse.dart';
import '../../Models/Response/UserMessagesResponse.dart';
import '../../Models/Response/VerifyEmailError.dart';
import '../../Models/Response/VerifyEmailResponse.dart';
import '../../Models/Response/registerError.dart';
import '../local/sharedPreference.dart';
import 'apiConstants.dart';

class ApiManager {
  static const String baseUrl =
      "https://smartcollgeapp-production.up.railway.app/api"; // عدلي اللينك بتاع سيرفرك

  Future<Either<RegisterError, StudentRegisterResponse>> studentRegister(
    String name,
    String email,
    String password,
    String role,
      String level,
      String department,
  ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(
          ApiConstants.baseurl,
          ApiConstants.studentRegisterApi,
        );

        var requestBody = StudentRegisterRequest(
          email: email,
          password: password,
          name: name,
          role: role,
          level: level,
          department: department
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
        return left(
          RegisterError(
            success: false,
            error: ErrorDetails(
              code: 0,
              message: "No Internet Connection",
              // details: "Please check your connection and try again.",
            ),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      return left(
        RegisterError(
          success: false,
          error: ErrorDetails(
            code: -1,
            message: "Unexpected Error",
            // details: e.toString(),
          ),
        ),
      );
    }
  }

  Future<Either<RegisterError, CompleteProfileResponse>> completeProfile(
      String level,
      String department,
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(
          ApiConstants.baseurl,
          ApiConstants.completeProfileApi,
        );

        var requestBody = CompleteProfileRequest(

            level: level,
            department: department
        );


        print('Sending request to: $url');
        print('Request body: ${requestBody.toJson()}');

        final savedToken = await TokenStorage.getToken();

        var response = await http.post(
            url,
            body: requestBody.toJson(),
          headers: {
            "Authorization": "Bearer $savedToken",


          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var completeProfile = CompleteProfileResponse.fromJson(jsonResponse);
          return right(completeProfile);
        } else {
          // أخطاء السيرفر
          return left(RegisterError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
        return left(
          RegisterError(
            success: false,
            error: ErrorDetails(
              code: 0,
              message: "No Internet Connection",
              // details: "Please check your connection and try again.",
            ),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      return left(
        RegisterError(
          success: false,
          error: ErrorDetails(
            code: -1,
            message: "Unexpected Error",
            // details: e.toString(),
          ),
        ),
      );
    }
  }

  Future<Either<RegisterError, StudentRegisterResponse>> alumniRegister(
    AlumniRegisterRequest request,
  ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(
          ApiConstants.baseurl,
          ApiConstants.studentRegisterApi,
        );

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
        return left(
          RegisterError(
            success: false,
            error: ErrorDetails(code: 0, message: "No Internet Connection"),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      return left(
        RegisterError(
          success: false,
          error: ErrorDetails(code: -1, message: "Unexpected Error"),
        ),
      );
    }
  }

  Future<Either<VerifyError, VerifyEmailResponse>> verifyEmail(
    VerifyEmailRequest request,
  ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.verifyEmailApi);

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
        } else {
          // أخطاء السيرفر
          return left(VerifyError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
        return left(VerifyError(code: 0, message: 'No internet connection'));
      }
    } catch (e) {
      print('Exception: $e');
      return left(VerifyError(code: -1, message: "Unexpected Error"));
    }
  }

  Future<Either<LoginError, LoginResponse>> login(
    String email,
    String password,
  ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.LoginApi);

        var requestBody = LoginRequest(
          email: email ?? '',
          password: password ?? '',
        );

        print('Sending request to: $url');
        print('Request body: ${requestBody.toJson()}');

        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
            requestBody.toJson(),
          ), // تأكد toJson يرجع Map<String, dynamic>
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var registerResponse = LoginResponse.fromJson(jsonResponse);
          return right(registerResponse);
        } else {
          // أخطاء السيرفر
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
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
      print('Exception: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(code: -1, message: "Unexpected Error"),
        ),
      );
    }
  }

  Future<Either<LoginError, SendEmailResponse>> sendEmail(String email) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.sendEmailApi);

        var requestBody = SendEmailRequest(email: email ?? '');

        print('Sending request to: $url');
        print('Request body: ${requestBody.toJson()}');

        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
            requestBody.toJson(),
          ), // تأكد toJson يرجع Map<String, dynamic>
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var sendEmailResponse = SendEmailResponse.fromJson(jsonResponse);
          return right(sendEmailResponse);
        } else {
          // أخطاء السيرفر
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
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
      print('Exception: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(code: -1, message: "Unexpected Error"),
        ),
      );
    }
  }

  Future<Either<VerifyError, ResetPasswordResponse>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.resetPassApi);

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
          final resetPassResponse = ResetPasswordResponse.fromJson(
            jsonResponse,
          );
          return right(resetPassResponse);
        } else {
          // أخطاء السيرفر
          return left(VerifyError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
        return left(VerifyError(code: 0, message: 'No internet connection'));
      }
    } catch (e) {
      print('Exception: $e');
      return left(VerifyError(code: -1, message: "Unexpected Error"));
    }
  }

  Future<Either<LoginError, ChangePaswwordResponse>> changePassword(
    String email,
    String code,
    String newPassword,
  ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.changePassApi);

        var requestBody = ChangePasswordRequest(
          email: email ?? '',
          code: code ?? '',
          newPassword: newPassword ?? '',
        );

        print('Sending request to: $url');
        print('Request body: ${requestBody.toJson()}');

        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
            requestBody.toJson(),
          ), // تأكد toJson يرجع Map<String, dynamic>
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var changePassResponse = ChangePaswwordResponse.fromJson(
            jsonResponse,
          );
          return right(changePassResponse);
        } else {
          // أخطاء السيرفر
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
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
      print('Exception: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(code: -1, message: "Unexpected Error"),
        ),
      );
    }
  }

  Future<Either<LoginError, GoogleResponse>> googleLogin(String token , String role) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        // الـ endpoint لازم يحدد من الباك
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.googleLoginApi);

        var requestBody = {
          "token": token, // ده اللي جاي من GoogleSignIn
          "role":role,
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
        }
        else {
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش إنترنت
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
      print('Exception in Google Login: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(code: -1, message: "Unexpected Error"),
        ),
      );
    }
  }

  Future<Either<LoginError, NotificationResponse>> sendNotification(
      NotificationRequest request,
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.notificationApi);

        print('Sending Notification request to: $url');
        print('Request body: ${request.toJson()}');

        // final prefs = await SharedPreferences.getInstance();
        // final token = prefs.getString("user_token");

        final savedToken = await TokenStorage.getToken();

        if (savedToken == null) {
          print("⚠️ No auth token saved, user might not be logged in.");
          return left(
            LoginError(
              success: false,
              error: LoginDetailsError(
                code: 401,
                message: "Unauthorized: No token found, please login again.",
              ),
            ),
          );
        }


        var response = await http.post(
          url,
          body: jsonEncode(request.toJson()),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $savedToken",


          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var notifResponse = NotificationResponse.fromJson(jsonResponse);
          return right(notifResponse);
        } else {
          // أخطاء من السيرفر
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش إنترنت
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
      print('Exception in sendNotification: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(code: -1, message: "Unexpected Error"),
        ),
      );
    }
  }



  Future<Either<LoginError, GetNotificationResponse>> getNotification() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.getNotificationApi);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var getNotificationResponse = GetNotificationResponse.fromJson(jsonResponse);

        return right(getNotificationResponse);
      } else {
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
  }


  Future<Either<LoginError, NotificationDetailsResponse>> getNotificationByID(String notificationId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/user/notification/$notificationId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var NotificationResponse = NotificationDetailsResponse.fromJson(jsonResponse);
        return right(NotificationResponse);
      } else {
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
  }


  Future<Either<LoginError, CounterResponse>> getCounter() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.counterApi);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var counterResponse = CounterResponse.fromJson(jsonResponse);

        return right(counterResponse);
      } else {
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
  }

  // Future<Either<LoginError, SendMessageResponse>> sendMessage({
  //   required String adminId,
  //   required String userId,
  //   required String text,
  // }) async {
  //   try {
  //     final connectivityResult = await Connectivity().checkConnectivity();
  //
  //     if (connectivityResult == ConnectivityResult.mobile ||
  //         connectivityResult == ConnectivityResult.wifi) {
  //       Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.sendMessageApi);
  //
  //       final savedToken = await TokenStorage.getToken();
  //
  //       if (savedToken == null) {
  //         print("⚠️ No auth token saved, user might not be logged in.");
  //         return left(
  //           LoginError(
  //             success: false,
  //             error: LoginDetailsError(
  //               code: 401,
  //               message: "Unauthorized: No token found, please login again.",
  //             ),
  //           ),
  //         );
  //       }
  //
  //       var requestBody = {
  //         "adminId": adminId,
  //         "userId": userId,
  //         "text": text,
  //       };
  //
  //       print('Sending request to: $url');
  //       print('Request body: $requestBody');
  //
  //       var response = await http.post(
  //         url,
  //         headers: {
  //           "Authorization": "Bearer $savedToken",
  //           "Content-Type": "application/json",
  //         },
  //         body: jsonEncode(requestBody),
  //       );
  //
  //       print('Response status: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //
  //       var jsonResponse = jsonDecode(response.body);
  //
  //       if (response.statusCode >= 200 && response.statusCode < 300) {
  //         var sendMessageResponse = SendMessageResponse.fromJson(jsonResponse);
  //         return right(sendMessageResponse);
  //       } else {
  //         return left(LoginError.fromJson(jsonResponse));
  //       }
  //     } else {
  //       return left(
  //         LoginError(
  //           success: false,
  //           error: LoginDetailsError(
  //             code: 0,
  //             message: "No Internet Connection",
  //           ),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //     return left(
  //       LoginError(
  //         success: false,
  //         error: LoginDetailsError(
  //           code: -1,
  //           message: "Unexpected Error",
  //         ),
  //       ),
  //     );
  //   }
  // }
  //
  Future<Either<LoginError, AllMessagesResponse>> getMessages() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.getMessagesApi);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var allMessagesResponse = AllMessagesResponse.fromJson(jsonResponse);
        return right(allMessagesResponse);
      } else {
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
  }

  //
  // Future<Either<LoginError, DeleteMessageResponse>> deleteMessage(String msgId) async {
  //   final connectivityResult = await Connectivity().checkConnectivity();
  //
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //     Uri url = Uri.https(ApiConstants.baseurl, "/api/user/chat/messages/$msgId");
  //
  //     final savedToken = await TokenStorage.getToken();
  //
  //     if (savedToken == null) {
  //       print("⚠️ No auth token saved, user might not be logged in.");
  //       return left(
  //         LoginError(
  //           success: false,
  //           error: LoginDetailsError(
  //             code: 401,
  //             message: "Unauthorized: No token found, please login again.",
  //           ),
  //         ),
  //       );
  //     }
  //
  //     var response = await http.delete(
  //       url,
  //       headers: {
  //         "Authorization": "Bearer $savedToken",
  //         "Content-Type": "application/json",
  //       },
  //     );
  //
  //     print('Mark as read status: ${response.statusCode}');
  //     print('Mark as read body: ${response.body}');
  //
  //     var jsonResponse = jsonDecode(response.body);
  //
  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       var deleteMessageResponse = DeleteMessageResponse.fromJson(jsonResponse);
  //       return right(deleteMessageResponse);
  //     } else {
  //       return left(LoginError.fromJson(jsonResponse));
  //     }
  //   } else {
  //     return left(
  //       LoginError(
  //         success: false,
  //         error: LoginDetailsError(
  //           code: 0,
  //           message: "No Internet Connection",
  //         ),
  //       ),
  //     );
  //   }
  // }




  Future<Either<LoginError, ExamsResponse>> getExams() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.examsApi);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var examsResponse = ExamsResponse.fromJson(jsonResponse);

        return right(examsResponse);
      } else {
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
  }

  Future<Either<LoginError, ExamDetailsResponse>> getExamsByID(String examId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/user/exam/$examId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var examDetailsResponse = ExamDetailsResponse.fromJson(jsonResponse);
        return right(examDetailsResponse);
      } else {
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
  }


}
