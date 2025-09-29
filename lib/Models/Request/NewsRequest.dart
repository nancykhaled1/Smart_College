class NewsRequest {
  final String? title;
  final String? description;
  final String? category;
  final String? image;
  final bool? isImportant;
  final DateTime? publishDate;

  NewsRequest({
    this.title,
    this.description,
    this.category,
    this.image,
    this.isImportant,
    this.publishDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'image': image,
      'isImportant': isImportant,
      'publishDate': publishDate?.toIso8601String(),
    };
  }

  factory NewsRequest.fromJson(Map<String, dynamic> json) {
    return NewsRequest(
      title: json['title'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      isImportant: json['isImportant'],
      publishDate: json['publishDate'] != null 
          ? DateTime.parse(json['publishDate']) 
          : null,
    );
  }
}

