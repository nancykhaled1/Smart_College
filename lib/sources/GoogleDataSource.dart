import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/GoogleRequest.dart';
import 'package:smart_college/Models/Response/GoogleResponse.dart';
import 'package:smart_college/Models/Response/LoginError.dart';

import '../Models/Request/AlumniRegisterRequest.dart';
import '../Models/Request/studentRegisterRequest.dart';
import '../Models/Response/StudentRegisterResponse.dart';
import '../Models/Response/registerError.dart';
import '../services/remote/apiManager.dart';

class GoogleDataSource {
  final ApiManager apiManager;

  GoogleDataSource(this.apiManager);

  Future<Either<LoginError, GoogleResponse>> google(
      GoogleLoginRequest request) {
    return apiManager.googleLogin(request.idToken);
  }
}
