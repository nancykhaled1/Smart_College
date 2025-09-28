import 'package:dartz/dartz.dart';
import 'package:smart_college/Models/Response/NewsError.dart';
import 'package:smart_college/Models/Response/NewsListResponse.dart';
import 'package:smart_college/Models/Response/news_model.dart';
import '../services/remote/apiManager.dart';

class NewsRemoteDataSource {
  final ApiManager apiManager;

  NewsRemoteDataSource(this.apiManager);

  Future<Either<NewsError, NewsListResponse>> getAllNews({
    int page = 1,
    int limit = 10,
    bool random = true,
  }) {
    return apiManager.getAllNews(page: page, limit: limit, random: random);
  }

  Future<Either<NewsError, NewsModel>> getNewsById(String id) {
    return apiManager.getNewsById(id);
  }

  Future<Either<NewsError, NewsListResponse>> getLatestNews({
    int count = 3,
    bool random = true,
  }) {
    return apiManager.getLatestNews(count: count, random: random);
  }

  Future<Either<NewsError, NewsListResponse>> getImportantNews() {
    return apiManager.getImportantNews();
  }

  Future<Either<NewsError, NewsListResponse>> searchNews({
    String? query,
    int page = 1,
    int limit = 10,
  }) {
    return apiManager.searchNews(
      query: query,
      page: page,
      limit: limit,
    );
  }


  Future<Either<NewsError, NewsListResponse>> getRandomNews({
    int count = 10,
  }) {
    return apiManager.getRandomNews(count: count);
  }
}

