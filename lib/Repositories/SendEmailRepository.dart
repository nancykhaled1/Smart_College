import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/SendEmailRequest.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/SendEmailResponse.dart';
import 'package:smart_college/sources/SendEmailDataSource.dart';

class SendEmailRepository {
  final SendEmailRemoteDataSource remoteDataSource;

  SendEmailRepository(this.remoteDataSource);

  Future<Either<LoginError, SendEmailResponse>> sendEmail(
      SendEmailRequest request) {
    return remoteDataSource.sendEmail(request);
  }
}