import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:smart_college/Models/Request/ChangePasswordRequest.dart';
import 'package:smart_college/Models/Request/CompleteProfileRequest.dart';
import 'package:smart_college/Models/Request/ResetPasswordRequest.dart';
import 'package:smart_college/Models/Request/SaveAnswersRequest.dart';
import 'package:smart_college/Models/Request/StartAttemptsRequest.dart';
import 'package:smart_college/Models/Request/SubmitRequest.dart';
import 'package:smart_college/Models/Request/UpdateProfileRequest.dart';
import 'package:smart_college/Models/Response/ChangePaswwordResponse.dart';
import 'package:smart_college/Models/Response/CompleteProfileResponse.dart';
import 'package:smart_college/Models/Response/CounterResponse.dart';
import 'package:smart_college/Models/Response/DepartmentResponse.dart';
import 'package:smart_college/Models/Response/ExamsResponse.dart';
import 'package:smart_college/Models/Response/LevelResponse.dart';
import 'package:smart_college/Models/Response/MyAttemptsResponse.dart';
import 'package:smart_college/Models/Response/ProfileResponse.dart';
import 'package:smart_college/Models/Response/QuestionsResponse.dart';
import 'package:smart_college/Models/Response/ResetPasswordResponse.dart';
import 'package:smart_college/Models/Response/SaveAnswersResponse.dart';
import 'package:smart_college/Models/Response/SubmitResponse.dart';
import 'package:smart_college/Models/Response/UpdateProfile.dart';
import 'package:smart_college/Models/Response/templateModel.dart';
import 'package:smart_college/services/local/sharedPreference.dart';
import 'package:smart_college/Models/Response/SaveAnswersResponse.dart';
import 'package:smart_college/Models/Response/SubmitResponse.dart';
import 'package:smart_college/Models/Response/UpdateProfile.dart';
import '../../Models/Request/AlumniRegisterRequest.dart';
import '../../Models/Request/ImageRequest.dart';
import '../../Models/Request/LoginRequest.dart';
import '../../Models/Request/NotificationRequest.dart';
import '../../Models/Request/SendEmailRequest.dart';
import '../../Models/Request/VerifyEmailRequest.dart';
import '../../Models/Request/studentRegisterRequest.dart';
import '../../Models/Response/DeleteProfileResponse.dart';
import '../../Models/Response/ExamDetailsResponse.dart';
import '../../Models/Response/GetNotificationResponse.dart';
import '../../Models/Response/GoogleResponse.dart';
import '../../Models/Response/ImageResponse.dart';
import '../../Models/Response/LoginError.dart';
import '../../Models/Response/LoginResponse.dart';
import '../../Models/Response/NotificationDetailsResponse.dart';
import '../../Models/Response/NotificationResponse.dart';
import '../../Models/Response/SendEmailResponse.dart';
import '../../Models/Response/StartAttemptsResponse.dart';
import '../../Models/Response/StudentRegisterResponse.dart';
import '../../Models/Response/VerifyEmailError.dart';
import '../../Models/Response/VerifyEmailResponse.dart';
import '../../Models/Response/newsModel.dart';
import '../../Models/Response/openaiChatResponse.dart';
import '../../Models/Response/registerError.dart';
import '../../Models/Request/openaiChatRequest.dart';
import '../../Models/Response/registerError.dart';
import '../../Models/Response/subject_model.dart';
import '../local/sharedPreference.dart';
import 'apiConstants.dart';
import 'package:http_parser/http_parser.dart';



class ApiManager {

  /////////////////////////////Login/Register/
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

        // 🟢 إنشاء Multipart request
        var multipartRequest = http.MultipartRequest('POST', url);

        // 🟡 نضيف الحقول العادية (Text fields)
        multipartRequest.fields['name'] = request.name ?? '';
        multipartRequest.fields['email'] = request.email ?? '';
        multipartRequest.fields['password'] = request.password ?? '';
        multipartRequest.fields['role'] = request.role ?? '';

        if (request.graduatedData != null) {
          multipartRequest.fields['employment_status'] =
              request.graduatedData?.employmentStatus ?? '';
          multipartRequest.fields['job_title'] =
              request.graduatedData?.jobTitle ?? '';
          multipartRequest.fields['company_location'] =
              request.graduatedData?.companyLocation ?? '';
          multipartRequest.fields['company_email'] =
              request.graduatedData?.companyEmail ?? '';
          multipartRequest.fields['company_link'] =
              request.graduatedData?.companyLink ?? '';
          multipartRequest.fields['company_phone'] =
              request.graduatedData?.companyPhone ?? '';
          multipartRequest.fields['about_company'] =
              request.graduatedData?.aboutCompany ?? '';

          // 🟠 نضيف الفايل لو موجود
          if (request.graduatedData!.cv != null) {
            multipartRequest.files.add(
              await http.MultipartFile.fromPath(
                'cv', // اسم البارامتر المتوقع من السيرفر
                request.graduatedData!.cv!.path,
                contentType: MediaType('application', 'pdf'),

              ),
            );
          }
        }

        // 🟢 إرسال الطلب
        var streamedResponse = await multipartRequest.send();
        var response = await http.Response.fromStream(streamedResponse);

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var registerResponse = StudentRegisterResponse.fromJson(jsonResponse);
          return right(registerResponse);
        } else {
          return left(RegisterError.fromJson(jsonResponse));
        }
      } else {
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

  Future<Either<RegisterError, LevelResponse>> getLevel() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.levelApi);

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
        /// هنا بعمل parse للـ object كله
        var levelResponse = LevelResponse.fromJson(jsonResponse);

        return right(levelResponse);
      } else {
        return left(RegisterError.fromJson(jsonResponse));
      }
    } else {
      return left(
        RegisterError(
          success: false,
          error: ErrorDetails(
            code: 0,
            message: "No Internet Connection",
            // details: e.toString(),
          ),
        ),
      );
    }
  }

  Future<Either<RegisterError, DepartmentResponse>> getDepartment() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.departmentApi);

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
        /// هنا بعمل parse للـ object كله
        var departmentResponse = DepartmentResponse.fromJson(jsonResponse);

        return right(departmentResponse);
      } else {
        return left(RegisterError.fromJson(jsonResponse));
      }
    } else {
      return left(
        RegisterError(
          success: false,
          error: ErrorDetails(
            code: 0,
            message: "No Internet Connection",
            // details: e.toString(),
          ),
        ),
      );
    }
  }




  /////////////////////Notification/////////////////////////////////////
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

  // Future<Either<LoginError, AllMessagesResponse>> getMessages() async {
  //   final connectivityResult = await Connectivity().checkConnectivity();
  //
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //     Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.getMessagesApi);
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
  //     var response = await http.get(
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
  //       var allMessagesResponse = AllMessagesResponse.fromJson(jsonResponse);
  //       return right(allMessagesResponse);
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
  ////////////////////////////////////////////////////////////////////////////////




















  // News API Methods

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

  // Search Lectures
  Future<Either<LoginError, LectureResponseModel>> searchLectures(String query) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        // Build URL with proper query parameters (Uri.https encodes automatically)
        Uri url = Uri.https(
          ApiConstants.baseurl,
          '/api/user/lecture/search',
          {'q': query},
        );
        print('📡 Searching lectures from: $url');

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

        print('📥 Lecture search API Response status: ${response.statusCode}');
        print('📥 Lecture search API Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var lectureResponse = LectureResponseModel.fromJson(jsonResponse);
          print('✅ Lectures search successful: ${lectureResponse.data.length} lectures found');
          return right(lectureResponse);
        } else {
          print('❌ Lecture search API Error: ${jsonResponse.toString()}');
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
      print('❌ Exception in searchLectures: $e');
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

  // Search News
  Future<Either<LoginError, NewsResponse>> searchNews(String query) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        // Build URL with proper query parameters (Uri.https encodes automatically)
        Uri url = Uri.https(
          ApiConstants.baseurl,
          '/api/user/news/search',
          {'q': query},
        );
        print('📡 Searching news from: $url');

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

        print('📥 News search API Response status: ${response.statusCode}');
        print('📥 News search API Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var newsResponse = NewsResponse.fromJson(jsonResponse);
          print('✅ News search successful: ${newsResponse.data.length} news items found');
          return right(newsResponse);
        } else {
          print('❌ News search API Error: ${jsonResponse.toString()}');
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
      print('❌ Exception in searchNews: $e');
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

  // OpenAI Chat API
  Future<Either<LoginError, OpenAIChatResponse>> openAIChat(String message) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.openAIChatApi);
        print('📡 Sending OpenAI chat request to: $url');

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

        final requestBody = OpenAIChatRequest(prompt: message);
        final jsonBody = jsonEncode(requestBody.toJson());

        var response = await http.post(
          url,
          headers: {
            "Authorization": "Bearer $savedToken",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonBody,
        );

        print('📥 OpenAI Chat API Response status: ${response.statusCode}');
        print('📥 OpenAI Chat API Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          // Ensure jsonResponse is a Map, not a List
          if (jsonResponse is! Map<String, dynamic>) {
            print('❌ OpenAI Chat API Error: Expected Map but got ${jsonResponse.runtimeType}');
            return left(
              LoginError(
                success: false,
                error: LoginDetailsError(
                  code: -1,
                  message: "حدث خطأ غير متوقع: Invalid response format",
                ),
              ),
            );
          }
          var chatResponse = OpenAIChatResponse.fromJson(jsonResponse);
          print('✅ OpenAI Chat successful: ${chatResponse.data}');
          return right(chatResponse);
        } else {
          // Handle error response - ensure it's a Map
          if (jsonResponse is Map<String, dynamic>) {
            print('❌ OpenAI Chat API Error: ${jsonResponse.toString()}');
            return left(LoginError.fromJson(jsonResponse));
          } else {
            return left(
              LoginError(
                success: false,
                error: LoginDetailsError(
                  code: response.statusCode,
                  message: "حدث خطأ في الاستجابة",
                ),
              ),
            );
          }
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
      print('❌ Exception in openAIChat: $e');
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

  /////////////////////Exams///////////////////////////
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
      Uri url = Uri.https(ApiConstants.baseurl, "/api/user/exam/exams/$examId");

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

  Future<Either<LoginError, QuestionsResponse>> getQuestions(String examId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/user/exam/exams/$examId/questions");

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

class ApiManager {

  /////////////////////////////Login/Register/
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
        var questionsResponse = QuestionsResponse.fromJson(jsonResponse);
        return right(questionsResponse);
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

  Future<Either<LoginError, StartAttemptsResponse>> startAttempt(String examId) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.attemptApi);

        var requestBody = StartAttemptsRequest(
          examId: examId ?? '',

        );

        print('Sending Notification request to: $url');
        print('Request body: ${requestBody.toJson()}');


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
          body: jsonEncode(requestBody.toJson()),
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
          var startAttemptsResponse = StartAttemptsResponse.fromJson(jsonResponse);
          return right(startAttemptsResponse);
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


  Future<Either<LoginError, SaveAnswersResponse>> saveAnswers(String attemptId , String questionId , String answer,String examId ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.saveAnsApi);

        var requestBody = SaveAnswersRequest(
            attemptId: attemptId,
            questionId: questionId,
            answer: answer,
            examId: examId

        );

        print('Sending Notification request to: $url');
        print('Request body: ${requestBody.toJson()}');


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
            );
          }
        }


        var response = await http.post(
          url,
          body: jsonEncode(requestBody.toJson()),
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
          var saveAnswersResponse = SaveAnswersResponse.fromJson(jsonResponse);
          return right(saveAnswersResponse);
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

  Future<Either<LoginError, SubmitResponse>> submitAttempt(String attemptId) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.submitApi);

        var requestBody = SubmitRequest(
          attemptId: attemptId,


        );

        print('Sending Notification request to: $url');
        print('Request body: ${requestBody.toJson()}');


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
          body: jsonEncode(requestBody.toJson()),
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
          var submitResponse = SubmitResponse.fromJson(jsonResponse);
          return right(submitResponse);
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

  Future<Either<LoginError, MyAttemptsResponse>> getAttempts() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.myAttemptApi);

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
        var myAttemptsResponse = MyAttemptsResponse.fromJson(jsonResponse);

        return right(myAttemptsResponse);
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

  /////////////////////////////Profile////////////////////////////////////////////////////

  Future<Either<LoginError, ProfileResponse>> getProfile() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.profileApi);

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
        var profileResponse = ProfileResponse.fromJson(jsonResponse);

        return right(profileResponse);
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

  Future<Either<LoginError, UpdateProfile>> updateData(UpdateProfileRequest request) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        return left(LoginError(
          success: false,
          error: LoginDetailsError(code: 0, message: "No Internet Connection"),
        ));
      }

      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.updateDataApi);
      print('📤 Sending update request to: $url');

      final savedToken = await TokenStorage.getToken();
      if (savedToken == null) {
        print("⚠️ No auth token saved.");
        return left(LoginError(
          success: false,
          error: LoginDetailsError(code: 401, message: "Unauthorized"),
        ));
      }

      var graduated = request.graduatedData;
      var hasFile = graduated?.cv is File;

      http.Response response;

      if (hasFile) {
        // 🔹 الحالة الأولى: المستخدم اختار ملف جديد
        print("📎 Sending multipart request with file...");

        var multipartRequest = http.MultipartRequest("PUT", url);
        multipartRequest.headers['Authorization'] = "Bearer $savedToken";

        multipartRequest.fields['name'] = request.name ?? '';
        multipartRequest.fields['email'] = request.email ?? '';
        multipartRequest.fields['department'] = request.department ?? '';

        // باقي بيانات graduatedData
        multipartRequest.fields['employment_status'] = graduated?.employmentStatus ?? '';
        multipartRequest.fields['job_title'] = graduated?.jobTitle ?? '';
        multipartRequest.fields['company_location'] = graduated?.companyLocation ?? '';
        multipartRequest.fields['company_email'] = graduated?.companyEmail ?? '';
        multipartRequest.fields['company_link'] = graduated?.companyLink ?? '';
        multipartRequest.fields['company_phone'] = graduated?.companyPhone ?? '';
        multipartRequest.fields['about_company'] = graduated?.aboutCompany ?? '';

        multipartRequest.files.add(await http.MultipartFile.fromPath(
          'cv',
          graduated!.cv!.path,
          contentType: MediaType('application', 'pdf'), // ✅ تحديد نوع الملف صراحة

        ));

        final streamedResponse = await multipartRequest.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // 🔹 الحالة الثانية: مفيش فايل جديد، نستخدم JSON عادي
        print("🧾 Sending JSON request (no new file)");

        response = await http.put(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $savedToken",
          },
          body: jsonEncode(request.toJson()),
        );
      }

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return right(UpdateProfile.fromJson(jsonResponse));
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } catch (e) {
      print('❌ Exception in updateData: $e');
      return left(LoginError(
        success: false,
        error: LoginDetailsError(code: -1, message: "Unexpected Error"),
      ));
    }
  }

  Future<Either<LoginError, DeleteProfileResponse>> deleteProfile() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.deleteApi);

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

      var response = await http.delete(
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
        var deleteProfileResponse = DeleteProfileResponse.fromJson(jsonResponse);

        return right(deleteProfileResponse);
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

  Future<Either<LoginError, ImageResponse>> uploadProfileImage(ImageRequest request) async {
    try {
      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        return left(LoginError(
          success: false,
          error: LoginDetailsError(code: 401, message: "Unauthorized: Please login again."),
        ));
      }

      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.updateImageApi);

      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",
        },
        body: jsonEncode(request.toJson()),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return right(ImageResponse.fromJson(jsonResponse));
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } catch (e) {
      print("🚨 uploadProfileImage error: $e");
      return left(LoginError(
        success: false,
        error: LoginDetailsError(code: -1, message: "Unexpected error occurred"),
      ));
    }
  }

/////////////////////
///// Get Templates
  Future<Either<LoginError, TemplateResponse>> getTemplates() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        Uri url = Uri.https(
          ApiConstants.baseurl,
          ApiConstants.templatesApi,
        );

        print('📡 Fetching templates from: $url');

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

        print('📥 Templates API Response status: ${response.statusCode}');
        print('📥 Templates API Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var templateResponse = TemplateResponse.fromJson(jsonResponse);
          print('✅ Templates fetched successfully: ${templateResponse.data.length} templates');
          return right(templateResponse);
        } else {
          print('❌ Templates API Error: ${jsonResponse.toString()}');
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
      print('❌ Exception in getTemplates: $e');
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

  // Get Template By ID
  Future<Either<LoginError, TemplateDetailResponse>> getTemplateById(String templateId) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.templateByIdApi(templateId));
        print('📡 Fetching template details from: $url');
        
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
        
        print('📥 Template details API Response status: ${response.statusCode}');
        print('📥 Template details API Response body: ${response.body}');
        
        var jsonResponse = jsonDecode(response.body);
        
        if (response.statusCode >= 200 && response.statusCode < 300) {
          var templateDetailResponse = TemplateDetailResponse.fromJson(jsonResponse);
          print('✅ Template details fetched successfully');
          return right(templateDetailResponse);
        } else {
          print('❌ Template details API Error: ${jsonResponse.toString()}');
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
      print('❌ Exception in getTemplateById: $e');
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

  // Search Templates
  Future<Either<LoginError, TemplateResponse>> searchTemplates(String query) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        // Build URL with proper query parameters (Uri.https encodes automatically)
        Uri url = Uri.https(
          ApiConstants.baseurl,
          '/api/user/templates/search',
          {'q': query},
        );
        print('📡 Searching templates from: $url');

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

        print('📥 Template search API Response status: ${response.statusCode}');
        print('📥 Template search API Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var templateResponse = TemplateResponse.fromJson(jsonResponse);
          print('✅ Templates search successful: ${templateResponse.data.length} templates found');
          return right(templateResponse);
        } else {
          print('❌ Template search API Error: ${jsonResponse.toString()}');
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
      print('❌ Exception in searchTemplates: $e');
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
