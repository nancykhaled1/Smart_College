import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/StartAttemptsRequest.dart';
import 'package:smart_college/Models/Response/ExamDetailsResponse.dart';
import 'package:smart_college/Models/Response/ExamsResponse.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/QuestionsResponse.dart';
import 'package:smart_college/sources/ExamsDataSource.dart';

import '../Models/Response/StartAttemptsResponse.dart';


class ExamsRepository {
  final ExamsRemoteDataSource remoteDataSource;

  ExamsRepository(this.remoteDataSource);

  Future<Either<LoginError, ExamsResponse>> getExams() {
    return remoteDataSource.getExams();
  }

  Future<Either<LoginError, ExamDetailsResponse>> getExamById(String examId) {
    return remoteDataSource.getExamById(examId);
  }


  Future<Either<LoginError, QuestionsResponse>> getQuestions(String examId) {
    return remoteDataSource.getQuestions(examId);
  }

  Future<Either<LoginError, StartAttemptsResponse>> startAttempt(String examId) {
    return remoteDataSource.startAttempt(examId);
  }
}