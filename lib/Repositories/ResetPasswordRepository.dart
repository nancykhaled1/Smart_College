import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/ResetPasswordRequest.dart';
import 'package:smart_college/Models/Request/VerifyEmailRequest.dart';
import 'package:smart_college/Models/Response/ResetPasswordResponse.dart';
import 'package:smart_college/Models/Response/VerifyEmailError.dart';
import 'package:smart_college/Models/Response/VerifyEmailResponse.dart';
import 'package:smart_college/sources/ResetPasswordDataSource.dart';

import '../sources/VerifyEmailDataSource.dart';

class ResetPasswordRepository {
  final ResetPasswordRemoteDataSource remoteDataSource;

  ResetPasswordRepository(this.remoteDataSource);

  Future<Either<VerifyError, ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request) {
    return remoteDataSource.resetPassword(request);
  }
}