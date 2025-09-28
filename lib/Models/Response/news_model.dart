  class NewsModel {
  final String id;
  final String title;
  final String content;
  final String mainImage;
  final List<String> images;
  final List<String> optional;
  final String type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NewsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.mainImage,
    required this.images,
    required this.optional,
    required this.type,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor لإنشاء موديل من JSON
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
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
      type: json['type'] ?? 'news',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
    );
  }

  // Method لتحويل الموديل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'content': content,
      'mainImage': mainImage,
      'images': images,
      'optional': optional,
      'type': type,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Factory constructor لإنشاء موديل من Map (للتوافق مع الكود القديم)
  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel.fromJson(map);
  }

  // Method لتحويل الموديل إلى Map (للتوافق مع الكود القديم)
  Map<String, dynamic> toMap() {
    return toJson();
  }

  // Method لإنشاء نسخة من الموديل مع تعديل بعض الخصائص
  NewsModel copyWith({
    String? id,
    String? title,
    String? content,
    String? mainImage,
    List<String>? images,
    List<String>? optional,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NewsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      mainImage: mainImage ?? this.mainImage,
      images: images ?? this.images,
      optional: optional ?? this.optional,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, content: $content, mainImage: $mainImage, images: $images, optional: $optional, type: $type, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NewsModel &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.mainImage == mainImage &&
        other.images == images &&
        other.optional == optional &&
        other.type == type &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        mainImage.hashCode ^
        images.hashCode ^
        optional.hashCode ^
        type.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
