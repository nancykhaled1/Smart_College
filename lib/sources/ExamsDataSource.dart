import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/ExamDetailsResponse.dart';
import 'package:smart_college/Models/Response/ExamsResponse.dart';

import 'package:smart_college/Models/Response/LoginError.dart';


import '../Models/Response/GetNotificationResponse.dart';
import '../services/remote/apiManager.dart';

class ExamsRemoteDataSource {
  final ApiManager apiManager;

  ExamsRemoteDataSource(this.apiManager);

  Future<Either<LoginError, ExamsResponse>> getExams() {
    return apiManager.getExams();
  }

  Future<Either<LoginError, ExamDetailsResponse>> getExamById(String examId) {
    return apiManager.getExamsByID(examId);
  }

}