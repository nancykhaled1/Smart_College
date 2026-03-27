import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/sources/getNotificationDataSource.dart';
import '../Models/Response/GetNotificationResponse.dart';

class GetNotificationRepository {
  final GetNotificationRemoteDataSource remoteDataSource;

  GetNotificationRepository(this.remoteDataSource);

  Future<Either<LoginError, GetNotificationResponse>> getNotification() {
    return remoteDataSource.GetNotification();
  }
}