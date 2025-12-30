import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/LoginError.dart' show LoginError;
import 'package:smart_college/Models/Response/subject_model.dart';

import 'package:smart_college/services/remote/apiManager.dart';

class LectureRemoteDataSource {
  final ApiManager apiManager;

  LectureRemoteDataSource({required this.apiManager});

  Future<Either<LoginError, LectureResponseModel>> getLectures() async {
    return apiManager.getLectures();
  }

  Future<Either<LoginError, LectureDetailResponse>> getLectureById(String id) async {
    return apiManager.getLectureById(id);
  }
}
