import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/CounterResponse.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/sources/CounterDataSource.dart';


class CounterRepository {
  final CounterRemoteDataSource remoteDataSource;

  CounterRepository(this.remoteDataSource);

  Future<Either<LoginError, CounterResponse>> getCounter() {
    return remoteDataSource.GetCounter();
  }
}