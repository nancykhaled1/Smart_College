import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/newsModel.dart';
import 'package:smart_college/sources/NewsDataSource.dart';

class NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepository(this.remoteDataSource);

  Future<Either<LoginError, NewsResponse>> getNews() {
    return remoteDataSource.getNews();
  }

  Future<Either<LoginError, NewsDetailResponse>> getNewsById(String id) {
    return remoteDataSource.getNewsById(id);
  }
}

