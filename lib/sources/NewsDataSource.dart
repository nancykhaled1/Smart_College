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
  }) {
    return apiManager.getAllNews(page: page, limit: limit);
  }

  Future<Either<NewsError, NewsModel>> getNewsById(String id) {
    return apiManager.getNewsById(id);
  }

  Future<Either<NewsError, NewsListResponse>> getLatestNews({
    int count = 3,
  }) {
    return apiManager.getLatestNews(count: count);
  }

  Future<Either<NewsError, NewsListResponse>> getImportantNews() {
    return apiManager.getImportantNews();
  }

  Future<Either<NewsError, NewsListResponse>> searchNews({
    String? query,
    String? category,
    int page = 1,
    int limit = 10,
  }) {
    return apiManager.searchNews(
      query: query,
      category: category,
      page: page,
      limit: limit,
    );
  }

  Future<Either<NewsError, NewsListResponse>> getNewsByCategory(
    String category, {
    int page = 1,
    int limit = 10,
  }) {
    return apiManager.getNewsByCategory(
      category,
      page: page,
      limit: limit,
    );
  }

  Future<Either<NewsError, List<String>>> getNewsCategories() {
    return apiManager.getNewsCategories();
  }
}

