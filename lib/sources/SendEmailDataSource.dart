import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/LoginRequest.dart';
import 'package:smart_college/Models/Request/SendEmailRequest.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/LoginResponse.dart';
import 'package:smart_college/Models/Response/SendEmailResponse.dart';

import '../services/remote/apiManager.dart';

class SendEmailRemoteDataSource {
  final ApiManager apiManager;

  SendEmailRemoteDataSource(this.apiManager);

  Future<Either<LoginError, SendEmailResponse>> sendEmail(
      SendEmailRequest request) {
    return apiManager.sendEmail(request.email!);
  }

}