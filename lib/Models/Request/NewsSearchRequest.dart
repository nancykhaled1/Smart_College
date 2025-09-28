class NewsSearchRequest {
  final String? query;
  final int? page;
  final int? limit;
  final bool? isImportant;

  NewsSearchRequest({
    this.query,
    this.page,
    this.limit,
    this.isImportant,
  });

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'page': page,
      'limit': limit,
      'isImportant': isImportant,
    };
  }

  factory NewsSearchRequest.fromJson(Map<String, dynamic> json) {
    return NewsSearchRequest(
      query: json['query'],
      page: json['page'],
      limit: json['limit'],
      isImportant: json['isImportant'],
    );
  }
}

