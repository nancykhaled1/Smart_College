// import 'package:dartz/dartz.dart';
// import 'package:smart_college/Models/Response/NewsError.dart';
// import 'package:smart_college/Models/Response/NewsListResponse.dart';
// import 'package:smart_college/Models/Response/news_model.dart';
// import 'package:smart_college/sources/NewsDataSource.dart';
//
// class NewsRepository {
//   final NewsRemoteDataSource remoteDataSource;
//
//   NewsRepository(this.remoteDataSource);
//
//   Future<Either<NewsError, NewsListResponse>> getAllNews({
//     int page = 1,
//     int limit = 10,
//     bool random = true,
//   }) {
//     return remoteDataSource.getAllNews(page: page, limit: limit, random: random);
//   }
//
//   Future<Either<NewsError, NewsModel>> getNewsById(String id) {
//     return remoteDataSource.getNewsById(id);
//   }
//
//   Future<Either<NewsError, NewsListResponse>> getLatestNews({
//     int count = 3,
//     bool random = true,
//   }) {
//     return remoteDataSource.getLatestNews(count: count, random: random);
//   }
//
//   Future<Either<NewsError, NewsListResponse>> getImportantNews() {
//     return remoteDataSource.getImportantNews();
//   }
//
//   Future<Either<NewsError, NewsListResponse>> searchNews({
//     String? query,
//     int page = 1,
//     int limit = 10,
//   }) {
//     return remoteDataSource.searchNews(
//       query: query,
//       page: page,
//       limit: limit,
//     );
//   }
//
//
//   Future<Either<NewsError, NewsListResponse>> getRandomNews({
//     int count = 10,
//   }) {
//     return remoteDataSource.getRandomNews(count: count);
//   }
// }
//
