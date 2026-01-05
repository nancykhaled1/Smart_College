import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/CompleteProfileRequest.dart';
import 'package:smart_college/Models/Response/CompleteProfileResponse.dart';
import 'package:smart_college/Models/Response/DepartmentResponse.dart';

import '../Models/Request/studentRegisterRequest.dart';
import '../Models/Response/LevelResponse.dart';
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

  Future<Either<RegisterError, LevelResponse>> getLevel() {
    return remoteDataSource.getLevel();
  }

  Future<Either<RegisterError, DepartmentResponse>> getDepartment() {
    return remoteDataSource.getDepartment();
  }
}
