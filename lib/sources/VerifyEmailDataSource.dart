import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/VerifyEmailRequest.dart';
import 'package:smart_college/Models/Response/VerifyEmailError.dart';
import 'package:smart_college/Models/Response/VerifyEmailResponse.dart';

import '../services/remote/apiManager.dart';

class VerifyEmailRemoteDataSource {
  final ApiManager apiManager;

  VerifyEmailRemoteDataSource(this.apiManager);

  Future<Either<VerifyError, VerifyEmailResponse>> verifyEmail(
      VerifyEmailRequest request) {
    return apiManager.verifyEmail(request);
  }

}