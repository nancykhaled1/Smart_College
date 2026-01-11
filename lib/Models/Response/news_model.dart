class NewsModel {
  final String title;
  final String content;
  final String mainImage;
  final List<String> images;
  final DateTime? createdAt;

  NewsModel({
    required this.title,
    required this.content,
    required this.mainImage,
    required this.images,
    this.createdAt,
  });
}