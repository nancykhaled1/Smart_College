import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/AlumniRegisterRequest.dart';

import '../Models/Request/studentRegisterRequest.dart';
import '../Models/Response/StudentRegisterResponse.dart';
import '../Models/Response/registerError.dart';
import '../sources/AlumniRegisterDataSource.dart';
import '../sources/StudentRegisterDataSource.dart';

class AlumniRepository {
  final AlumniRemoteDataSource remoteDataSource;

  AlumniRepository(this.remoteDataSource);

  Future<Either<RegisterError, StudentRegisterResponse>> registerAlumni(
      AlumniRegisterRequest request) {
    return remoteDataSource.registerAlumni(request);
  }
}
