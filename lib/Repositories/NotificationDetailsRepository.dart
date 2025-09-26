import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/NotificationDetailsResponse.dart';
import 'package:smart_college/sources/NotificationDetailsDataSource.dart';


class NotificationDetailsRepository {
  final NotificationDetailsRemoteDataSource remoteDataSource;

  NotificationDetailsRepository(this.remoteDataSource);

  Future<Either<LoginError, NotificationDetailsResponse>> getNotification(String notificationId) {
    return remoteDataSource.GetNotificationDetails(notificationId);
  }
}