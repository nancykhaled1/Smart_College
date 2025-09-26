import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/AlumniRegisterRequest.dart';
import 'package:smart_college/Models/Request/CompleteProfileRequest.dart';
import 'package:smart_college/Models/Response/CompleteProfileResponse.dart';

import '../Models/Request/studentRegisterRequest.dart';
import '../Models/Response/StudentRegisterResponse.dart';
import '../Models/Response/registerError.dart';
import '../services/remote/apiManager.dart';

class StudentRemoteDataSource {
  final ApiManager apiManager;

  StudentRemoteDataSource(this.apiManager);

  Future<Either<RegisterError, StudentRegisterResponse>> registerStudent(
      StudentRegisterRequest request) {
    return apiManager.studentRegister(request.name, request.email, request.password,request.role,request.level,request.department);
  }

  Future<Either<RegisterError, CompleteProfileResponse>> completeProfile(
      CompleteProfileRequest request) {
    return apiManager.completeProfile(request.level!, request.department!);
  }

}
