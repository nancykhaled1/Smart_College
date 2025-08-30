import 'package:dartz/dartz.dart';

import '../Models/Request/AlumniRegisterRequest.dart';
import '../Models/Request/studentRegisterRequest.dart';
import '../Models/Response/StudentRegisterResponse.dart';
import '../Models/Response/registerError.dart';
import '../services/remote/apiManager.dart';

class AlumniRemoteDataSource {
  final ApiManager apiManager;

  AlumniRemoteDataSource(this.apiManager);

  Future<Either<RegisterError, StudentRegisterResponse>> registerAlumni(
      AlumniRegisterRequest request) {
    return apiManager.alumniRegister(request);
  }
}
