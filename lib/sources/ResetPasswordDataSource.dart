import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/ResetPasswordRequest.dart';
import 'package:smart_college/Models/Request/VerifyEmailRequest.dart';
import 'package:smart_college/Models/Response/ResetPasswordResponse.dart';
import 'package:smart_college/Models/Response/VerifyEmailError.dart';
import 'package:smart_college/Models/Response/VerifyEmailResponse.dart';

import '../services/remote/apiManager.dart';

class ResetPasswordRemoteDataSource {
  final ApiManager apiManager;

  ResetPasswordRemoteDataSource(this.apiManager);

  Future<Either<VerifyError, ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request) {
    return apiManager.resetPassword(request);
  }

}