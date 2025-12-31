import 'package:dartz/dartz.dart';

import 'package:smart_college/Models/Response/LoginError.dart';


import '../Models/Response/GetNotificationResponse.dart';
import '../services/remote/apiManager.dart';

class GetNotificationRemoteDataSource {
  final ApiManager apiManager;

  GetNotificationRemoteDataSource(this.apiManager);

  Future<Either<LoginError, GetNotificationResponse>> GetNotification() {
    return apiManager.getNotification();
  }

}