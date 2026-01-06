// news_model.dart

class NewsResponse {
  final bool success;
  final List<News> data;

  NewsResponse({
    required this.success,
    required this.data,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => News.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((news) => news.toJson()).toList(),
    };
  }
}

class News {
  final String id;
  final String title;
  final String content;
  final String mainImage;
  final List<String> images;
  final List<String> optional;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.mainImage,
    required this.images,
    required this.optional,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      mainImage: json['mainImage'] ?? '',
      images: (json['images'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList() ?? [],
      optional: (json['optional'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList() ?? [],
      type: json['type'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      version: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'content': content,
      'mainImage': mainImage,
      'images': images,
      'optional': optional,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }

  // Helper methods للـ UI
  String get formattedCreatedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }

  bool get hasMultipleImages => images.length > 1;
  bool get hasOptionalFiles => optional.isNotEmpty;
  
  // Copy with method للتعديل
  News copyWith({
    String? id,
    String? title,
    String? content,
    String? mainImage,
    List<String>? images,
    List<String>? optional,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      mainImage: mainImage ?? this.mainImage,
      images: images ?? this.images,
      optional: optional ?? this.optional,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

  @override
  String toString() {
    return 'News{id: $id, title: $title, type: $type}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is News && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// News Detail Response Model (for single news item)
class NewsDetailResponse {
  final bool success;
  final News data;

  NewsDetailResponse({
    required this.success,
    required this.data,
  });

  factory NewsDetailResponse.fromJson(Map<String, dynamic> json) {
    return NewsDetailResponse(
      success: json['success'] ?? false,
      data: News.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

