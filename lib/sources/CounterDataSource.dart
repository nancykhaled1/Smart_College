import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/CounterResponse.dart';

import 'package:smart_college/Models/Response/LoginError.dart';


import '../Models/Response/GetNotificationResponse.dart';
import '../services/remote/apiManager.dart';

class CounterRemoteDataSource {
  final ApiManager apiManager;

  CounterRemoteDataSource(this.apiManager);

  Future<Either<LoginError, CounterResponse>> GetCounter() {
    return apiManager.getCounter();
  }

}