import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Request/StartAttemptsRequest.dart';
import 'package:smart_college/Models/Response/ExamDetailsResponse.dart';
import 'package:smart_college/Models/Response/ExamsResponse.dart';

import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/MyAttemptsResponse.dart';
import 'package:smart_college/Models/Response/QuestionsResponse.dart';
import 'package:smart_college/Models/Response/SaveAnswersResponse.dart';
import 'package:smart_college/Models/Response/StartAttemptsResponse.dart';


import '../Models/Response/GetNotificationResponse.dart';
import '../Models/Response/SubmitResponse.dart';
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


  Future<Either<LoginError, QuestionsResponse>> getQuestions(String examId) {
    return apiManager.getQuestions(examId);
  }

  Future<Either<LoginError, StartAttemptsResponse>> startAttempt(String examId) {
    return apiManager.startAttempt(examId);
  }



  Future<Either<LoginError, SaveAnswersResponse>> saveAnswers(String attemptId, String questionId, String answer , String examId ) {
    return apiManager.saveAnswers(attemptId, questionId, answer, examId);
  }


  Future<Either<LoginError, SubmitResponse>> submitAttempt(String attemptId) {
    return apiManager.submitAttempt(attemptId);
  }

  Future<Either<LoginError, MyAttemptsResponse>> getAttempt() {
    return apiManager.getAttempts();
  }
}