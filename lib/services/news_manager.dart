import 'package:smart_college/Models/Response/news_model.dart';
import 'package:smart_college/services/remote/apiManager.dart';

class NewsManager {
  static final ApiManager _apiManager = ApiManager();

  // Get specific news by ID only
  static Future<NewsModel?> getNewsById(String id) async {
    try {
      final result = await _apiManager.getNewsById(id);
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

  // Get single random news
  static Future<NewsModel?> getRandomNews() async {
    try {
      final result = await _apiManager.getRandomNews(count: 1);
      return result.fold(
        (error) {
          print('Error getting random news: ${error.message}');
          return null;
        },
        (response) => response.data.isNotEmpty ? response.data.first : null,
      );
    } catch (e) {
      print('Exception in getRandomNews: $e');
      return null;
    }
  }

  // Get single latest news
  static Future<NewsModel?> getLatestNews() async {
    try {
      final result = await _apiManager.getLatestNews(count: 1);
      return result.fold(
        (error) {
          print('Error getting latest news: ${error.message}');
          return null;
        },
        (response) => response.data.isNotEmpty ? response.data.first : null,
      );
    } catch (e) {
      print('Exception in getLatestNews: $e');
      return null;
    }
  }

  // Get single important news
  static Future<NewsModel?> getImportantNews() async {
    try {
      final result = await _apiManager.getImportantNews();
      return result.fold(
        (error) {
          print('Error getting important news: ${error.message}');
          return null;
        },
        (response) => response.data.isNotEmpty ? response.data.first : null,
      );
    } catch (e) {
      print('Exception in getImportantNews: $e');
      return null;
    }
  }
}
