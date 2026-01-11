// template_model.dart

class TemplateResponse {
  final bool success;
  final List<Template> data;

  TemplateResponse({
    required this.success,
    required this.data,
  });

  factory TemplateResponse.fromJson(Map<String, dynamic> json) {
    List<Template> templatesList = [];
    
    if (json['data'] != null) {
      if (json['data'] is Map<String, dynamic>) {
        final dataMap = json['data'] as Map<String, dynamic>;
        // Check if data contains 'templates' key
        if (dataMap['templates'] != null && dataMap['templates'] is List) {
          templatesList = (dataMap['templates'] as List)
              .map((item) {
                if (item is Map<String, dynamic>) {
                  return Template.fromJson(item);
                }
                return null;
              })
              .whereType<Template>()
              .toList();
        }
      } else if (json['data'] is List) {
        // If data is a List, process each item (backward compatibility)
        templatesList = (json['data'] as List)
            .map((item) {
              if (item is Map<String, dynamic>) {
                return Template.fromJson(item);
              }
              return null;
            })
            .whereType<Template>()
            .toList();
      }
    }
    
    return TemplateResponse(
      success: json['success'] ?? false,
      data: templatesList,
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
  final String content; // New field from API
  final String category; // Training, Diploma, Masters, Doctorate
  final String? image;
  final List<String>? images;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final String? companyName;
  final bool? isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  Template({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.category,
    this.image,
    this.images,
    this.startDate,
    this.endDate,
    this.location,
    this.companyName,
    this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? json['mainImage'],
      images: (json['images'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList(),
      startDate: json['startdate'] != null 
          ? DateTime.tryParse(json['startdate']) 
          : null,
      endDate: json['enddate'] != null 
          ? DateTime.tryParse(json['enddate']) 
          : null,
      location: json['location'],
      companyName: json['companyname'],
      isActive: json['IsActive'] ?? json['isActive'],
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
      'content': content,
      'category': category,
      'image': image,
      'images': images,
      'startdate': startDate?.toIso8601String(),
      'enddate': endDate?.toIso8601String(),
      'location': location,
      'companyname': companyName,
      'IsActive': isActive,
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
    String? content,
    String? category,
    String? image,
    List<String>? images,
    DateTime? startDate,
    DateTime? endDate,
    String? location,
    String? companyName,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) {
    return Template(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      category: category ?? this.category,
      image: image ?? this.image,
      images: images ?? this.images,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      companyName: companyName ?? this.companyName,
      isActive: isActive ?? this.isActive,
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
    Template template;
    
    if (json['data'] != null) {
      if (json['data'] is Map<String, dynamic>) {
        template = Template.fromJson(json['data'] as Map<String, dynamic>);
      } else if (json['data'] is List && (json['data'] as List).isNotEmpty) {
        // If data is a List, take the first item
        final firstItem = (json['data'] as List)[0];
        if (firstItem is Map<String, dynamic>) {
          template = Template.fromJson(firstItem);
        } else {
          // Create a default template if format is unexpected
          template = Template(
            id: '',
            title: '',
            description: '',
            content: '',
            category: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            version: 0,
          );
        }
      } else {
        // Create a default template if format is unexpected
        template = Template(
          id: '',
          title: '',
          description: '',
          content: '',
          category: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          version: 0,
        );
      }
    } else {
      // Create a default template if data is null
      template = Template(
        id: '',
        title: '',
        description: '',
        content: '',
        category: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        version: 0,
      );
    }
    
    return TemplateDetailResponse(
      success: json['success'] ?? false,
      data: template,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

