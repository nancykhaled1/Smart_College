import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/LoginError.dart';
import 'package:smart_college/Models/Response/newsModel.dart';
import 'package:smart_college/services/remote/apiManager.dart';

class NewsRemoteDataSource {
  final ApiManager apiManager;

  NewsRemoteDataSource(this.apiManager);

  Future<Either<LoginError, NewsResponse>> getNews() async {
    return await apiManager.getNews();
  }

  Future<Either<LoginError, NewsDetailResponse>> getNewsById(String id) async {
    return await apiManager.getNewsById(id);
  }

  Future<Either<LoginError, NewsResponse>> searchNews(String query) async {
    return await apiManager.searchNews(query);
  }
}
