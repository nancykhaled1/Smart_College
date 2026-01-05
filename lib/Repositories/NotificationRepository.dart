import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/LoginRequest.dart';
import 'package:smart_college/Models/Request/NotificationRequest.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/LoginResponse.dart';
import 'package:smart_college/Models/Response/NotificationResponse.dart';
import 'package:smart_college/sources/LoginDataSource.dart';
import 'package:smart_college/sources/NotificationDataSource.dart';

class NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepository(this.remoteDataSource);

  Future<Either<LoginError, NotificationResponse>> sendNotification(
      NotificationRequest request) {
    return remoteDataSource.sendNotification(request);
  }
}