import 'package:dartz/dartz.dart';

import '../Models/Request/studentRegisterRequest.dart';
import '../Models/Response/StudentRegisterResponse.dart';
import '../Models/Response/registerError.dart';
import '../sources/StudentRegisterDataSource.dart';

class StudentRepository {
  final StudentRemoteDataSource remoteDataSource;

  StudentRepository(this.remoteDataSource);

  Future<Either<RegisterError, StudentRegisterResponse>> registerStudent(
      StudentRegisterRequest request) {
    return remoteDataSource.registerStudent(request);
  }
}
