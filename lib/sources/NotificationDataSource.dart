import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/LoginRequest.dart';
import 'package:smart_college/Models/Request/NotificationRequest.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/LoginResponse.dart';
import 'package:smart_college/Models/Response/NotificationResponse.dart';

import '../services/remote/apiManager.dart';

class NotificationRemoteDataSource {
  final ApiManager apiManager;

  NotificationRemoteDataSource(this.apiManager);

  Future<Either<LoginError, NotificationResponse>> sendNotification(
      NotificationRequest request) {
    return apiManager.sendNotification(request);
  }

}