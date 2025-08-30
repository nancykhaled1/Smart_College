import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/LoginRequest.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/LoginResponse.dart';

import '../services/remote/apiManager.dart';

class LoginRemoteDataSource {
  final ApiManager apiManager;

  LoginRemoteDataSource(this.apiManager);

  Future<Either<LoginError, LoginResponse>> login(
      LoginRequest request) {
    return apiManager.login(request.email!, request.password!);
  }

}