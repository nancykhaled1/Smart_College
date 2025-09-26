import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/ExamDetailsResponse.dart';
import 'package:smart_college/Models/Response/ExamsResponse.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/sources/ExamsDataSource.dart';


class ExamsRepository {
  final ExamsRemoteDataSource remoteDataSource;

  ExamsRepository(this.remoteDataSource);

  Future<Either<LoginError, ExamsResponse>> getExams() {
    return remoteDataSource.getExams();
  }

  Future<Either<LoginError, ExamDetailsResponse>> getExamById(String examId) {
    return remoteDataSource.getExamById(examId);
  }
}