import 'package:smart_college/Models/Response/news_model.dart';

class NewsListResponse {
  final bool success;
  final List<NewsModel> data;
  final int? totalCount;
  final int? currentPage;
  final int? totalPages;
  final String? message;

  NewsListResponse({
    required this.success,
    required this.data,
    this.totalCount,
    this.currentPage,
    this.totalPages,
    this.message,
  });

  factory NewsListResponse.fromJson(Map<String, dynamic> json) {
    // Handle the new JSON structure where data contains a "news" array
    List<NewsModel> newsList = [];
    if (json['data'] != null && json['data']['news'] != null) {
      newsList = (json['data']['news'] as List<dynamic>?)
          ?.map((item) => NewsModel.fromJson(item))
          .toList() ?? [];
    } else if (json['data'] is List) {
      // Fallback for old structure
      newsList = (json['data'] as List<dynamic>?)
          ?.map((item) => NewsModel.fromJson(item))
          .toList() ?? [];
    }
    
    return NewsListResponse(
      success: json['success'] ?? false,
      data: newsList,
      totalCount: json['totalCount'] ?? newsList.length,
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((item) => item.toJson()).toList(),
      'totalCount': totalCount,
      'currentPage': currentPage,
      'totalPages': totalPages,
      'message': message,
    };
  }
}
