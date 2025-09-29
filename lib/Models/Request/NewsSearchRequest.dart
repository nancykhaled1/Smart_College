class NewsSearchRequest {
  final String? query;
  final String? category;
  final int? page;
  final int? limit;
  final bool? isImportant;

  NewsSearchRequest({
    this.query,
    this.category,
    this.page,
    this.limit,
    this.isImportant,
  });

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'category': category,
      'page': page,
      'limit': limit,
      'isImportant': isImportant,
    };
  }

  factory NewsSearchRequest.fromJson(Map<String, dynamic> json) {
    return NewsSearchRequest(
      query: json['query'],
      category: json['category'],
      page: json['page'],
      limit: json['limit'],
      isImportant: json['isImportant'],
    );
  }
}

