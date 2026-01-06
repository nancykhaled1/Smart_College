import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/GoogleRequest.dart';
import 'package:smart_college/Models/Response/GoogleResponse.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/sources/GoogleDataSource.dart';

class GoogleRepository {
  final GoogleDataSource remoteDataSource;

  GoogleRepository(this.remoteDataSource);

  Future<Either<LoginError, GoogleResponse>> google(
      GoogleLoginRequest request) {
    return remoteDataSource.google(request);
  }
}