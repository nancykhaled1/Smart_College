import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/LoginError.dart';

import 'package:smart_college/Models/Response/subject_model.dart';

import 'package:smart_college/sources/LectureDataSource.dart';

class LectureRepository {
  final LectureRemoteDataSource remoteDataSource;

  LectureRepository({required this.remoteDataSource});

  Future<Either<LoginError, List<LectureModel>>> getLectures() async {
    final result = await remoteDataSource.getLectures();

    return result.fold(
      (error) => left(error),
      (response) => right(response.data), 
    );
  }

  Future<Either<LoginError, LectureModel>> getLectureById(String id) async {
    final result = await remoteDataSource.getLectureById(id);

    return result.fold(
      (error) => left(error),
      (response) => right(response.data),
    );
  }
}
