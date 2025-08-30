import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/AlumniRegisterRequest.dart';

import '../Models/Request/studentRegisterRequest.dart';
import '../Models/Response/StudentRegisterResponse.dart';
import '../Models/Response/registerError.dart';
import '../services/remote/apiManager.dart';

class StudentRemoteDataSource {
  final ApiManager apiManager;

  StudentRemoteDataSource(this.apiManager);

  Future<Either<RegisterError, StudentRegisterResponse>> registerStudent(
      StudentRegisterRequest request) {
    return apiManager.studentRegister(request.name, request.email, request.password,request.role);
  }

}
