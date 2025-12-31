// template_model.dart

class TemplateResponse {
  final bool success;
  final List<Template> data;

  TemplateResponse({
    required this.success,
    required this.data,
  });

  factory TemplateResponse.fromJson(Map<String, dynamic> json) {
    return TemplateResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Template.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((template) => template.toJson()).toList(),
    };
  }
}

class Template {
  final String id;
  final String title;
  final String description;
  final String category; // Training, Diploma, Masters, Doctorate
  final String? image;
  final List<String>? images;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  Template({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.image,
    this.images,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? json['mainImage'],
      images: (json['images'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      version: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'category': category,
      'image': image,
      'images': images,
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

  bool get hasMultipleImages => (images?.length ?? 0) > 1;
  
  // Copy with method للتعديل
  Template copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? image,
    List<String>? images,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) {
    return Template(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

  @override
  String toString() {
    return 'Template{id: $id, title: $title, category: $category}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Template && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Template Detail Response Model (for single template item)
class TemplateDetailResponse {
  final bool success;
  final Template data;

  TemplateDetailResponse({
    required this.success,
    required this.data,
  });

  factory TemplateDetailResponse.fromJson(Map<String, dynamic> json) {
    return TemplateDetailResponse(
      success: json['success'] ?? false,
      data: Template.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

