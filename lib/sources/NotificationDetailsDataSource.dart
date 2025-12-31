import 'package:dartz/dartz.dart';

import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/NotificationDetailsResponse.dart';
import '../services/remote/apiManager.dart';

class NotificationDetailsRemoteDataSource {
  final ApiManager apiManager;

  NotificationDetailsRemoteDataSource(this.apiManager);

  Future<Either<LoginError, NotificationDetailsResponse>> GetNotificationDetails(String notificationId) {
    return apiManager.getNotificationByID(notificationId);
  }

}