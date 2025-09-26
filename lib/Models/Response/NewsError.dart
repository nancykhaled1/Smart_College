class NewsError {
  final bool success;
  final String message;
  final int? code;
  final String? details;

  NewsError({
    required this.success,
    required this.message,
    this.code,
    this.details,
  });

  factory NewsError.fromJson(Map<String, dynamic> json) {
    return NewsError(
      success: json['success'] ?? false,
      message: json['message'] ?? 'Unknown error',
      code: json['code'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'code': code,
      'details': details,
    };
  }
}

