import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/LoginRequest.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/LoginResponse.dart';
import 'package:smart_college/sources/LoginDataSource.dart';

class LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepository(this.remoteDataSource);

  Future<Either<LoginError, LoginResponse>> login(
      LoginRequest request) {
    return remoteDataSource.login(request);
  }
}