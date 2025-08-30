import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/ChangePasswordRequest.dart';
import 'package:smart_college/Models/Response/ChangePaswwordResponse.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/sources/ChangePasswordDataSource.dart';


class ChangePasswordRepository {
  final ChangePassRemoteDataSource remoteDataSource;

  ChangePasswordRepository(this.remoteDataSource);

  Future<Either<LoginError, ChangePaswwordResponse>> changePassword(
      ChangePasswordRequest request) {
    return remoteDataSource.changePassword(request);
  }
}