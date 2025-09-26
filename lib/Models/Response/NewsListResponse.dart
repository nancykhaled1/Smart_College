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
    return NewsListResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => NewsModel.fromJson(item))
          .toList() ?? [],
      totalCount: json['totalCount'] ?? json['data']?.length,
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
