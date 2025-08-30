import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/ChangePasswordRequest.dart';
import 'package:smart_college/Models/Response/ChangePaswwordResponse.dart';
import 'package:smart_college/Models/Response/LoginError.dart';

import '../services/remote/apiManager.dart';

class ChangePassRemoteDataSource {
  final ApiManager apiManager;

  ChangePassRemoteDataSource(this.apiManager);

  Future<Either<LoginError, ChangePaswwordResponse>> changePassword(
      ChangePasswordRequest request) {
    return apiManager.changePassword(request.email!, request.code!, request.newPassword!);
  }

}