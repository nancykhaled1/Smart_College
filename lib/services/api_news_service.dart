import 'package:smart_college/Models/Response/news_model.dart';
import 'package:smart_college/Repositories/NewsRepository.dart';
import 'package:smart_college/sources/NewsDataSource.dart';
import 'package:smart_college/services/remote/apiManager.dart';

class ApiNewsService {
  static final ApiManager _apiManager = ApiManager();
  static final NewsRemoteDataSource _dataSource = NewsRemoteDataSource(_apiManager);
  static final NewsRepository _repository = NewsRepository(_dataSource);

  // الحصول على جميع الأخبار
  static Future<List<NewsModel>> getAllNews({int page = 1, int limit = 10}) async {
    try {
      final result = await _repository.getAllNews(page: page, limit: limit);
      return result.fold(
        (error) {
          print('Error getting all news: ${error.message}');
          return <NewsModel>[];
        },
        (response) => response.data,
      );
    } catch (e) {
      print('Exception in getAllNews: $e');
      return <NewsModel>[];
    }
  }

  // الحصول على آخر الأخبار
  static Future<List<NewsModel>> getLatestNews({int count = 3}) async {
    try {
      final result = await _repository.getLatestNews(count: count);
      return result.fold(
        (error) {
          print('Error getting latest news: ${error.message}');
          return <NewsModel>[];
        },
        (response) => response.data,
      );
    } catch (e) {
      print('Exception in getLatestNews: $e');
      return <NewsModel>[];
    }
  }

  // الحصول على خبر محدد بالـ ID
  static Future<NewsModel?> getNewsById(String id) async {
    try {
      final result = await _repository.getNewsById(id);
      return result.fold(
        (error) {
          print('Error getting news by id: ${error.message}');
          return null;
        },
        (news) => news,
      );
    } catch (e) {
      print('Exception in getNewsById: $e');
      return null;
    }
  }

  // البحث في الأخبار
  static Future<List<NewsModel>> searchNews({
    String? query,
    String? category,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final result = await _repository.searchNews(
        query: query,
        category: category,
        page: page,
        limit: limit,
      );
      return result.fold(
        (error) {
          print('Error searching news: ${error.message}');
          return <NewsModel>[];
        },
        (response) => response.data,
      );
    } catch (e) {
      print('Exception in searchNews: $e');
      return <NewsModel>[];
    }
  }

  // الحصول على أخبار حسب الفئة
  static Future<List<NewsModel>> getNewsByCategory(
    String category, {
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final result = await _repository.getNewsByCategory(
        category,
        page: page,
        limit: limit,
      );
      return result.fold(
        (error) {
          print('Error getting news by category: ${error.message}');
          return <NewsModel>[];
        },
        (response) => response.data,
      );
    } catch (e) {
      print('Exception in getNewsByCategory: $e');
      return <NewsModel>[];
    }
  }

  // الحصول على جميع الفئات المتاحة
  static Future<List<String>> getAllCategories() async {
    try {
      final result = await _repository.getNewsCategories();
      return result.fold(
        (error) {
          print('Error getting categories: ${error.message}');
          return <String>[];
        },
        (categories) => categories,
      );
    } catch (e) {
      print('Exception in getAllCategories: $e');
      return <String>[];
    }
  }

  // الحصول على الأخبار المهمة
  static Future<List<NewsModel>> getImportantNews() async {
    try {
      final result = await _repository.getImportantNews();
      return result.fold(
        (error) {
          print('Error getting important news: ${error.message}');
          return <NewsModel>[];
        },
        (response) => response.data,
      );
    } catch (e) {
      print('Exception in getImportantNews: $e');
      return <NewsModel>[];
    }
  }
}
