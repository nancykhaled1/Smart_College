import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/VerifyEmailRequest.dart';
import 'package:smart_college/Models/Response/VerifyEmailError.dart';
import 'package:smart_college/Models/Response/VerifyEmailResponse.dart';

import '../sources/VerifyEmailDataSource.dart';

class VerifyEmailRepository {
  final VerifyEmailRemoteDataSource remoteDataSource;

  VerifyEmailRepository(this.remoteDataSource);

  Future<Either<VerifyError, VerifyEmailResponse>> verifyEmail(
      VerifyEmailRequest request) {
    return remoteDataSource.verifyEmail(request);
  }
}