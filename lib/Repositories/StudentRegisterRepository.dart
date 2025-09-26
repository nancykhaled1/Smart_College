import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/CompleteProfileRequest.dart';
import 'package:smart_college/Models/Response/CompleteProfileResponse.dart';

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

  Future<Either<RegisterError, CompleteProfileResponse>> completeProfile(
      CompleteProfileRequest request) {
    return remoteDataSource.completeProfile(request);
  }
}
