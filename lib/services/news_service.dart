//
// import 'package:smart_college/Models/Response/news_model.dart';
//
// class NewsService {
//   // قائمة بالأخبار - يمكن استبدالها بـ API في المستقبل
//   static final List<NewsModel> _newsList = [
//     NewsModel(
//       id: '1',
//       title: 'زيارة معالى رئيس الجامعة لكلية الحاسبات والمعلومات',
//       content: 'قام معالى رئيس الجامعة بزيارة كلية الحاسبات والمعلومات للاطلاع على أحدث التطورات والتقنيات المستخدمة في العملية التعليمية',
//       mainImage: 'https://via.placeholder.com/600x400.png?text=News+1',
//       images: const [],
//       type: 'news',
//       createdAt: DateTime(2024, 10, 17),
//       updatedAt: DateTime(2024, 10, 17),
//     ),
//     NewsModel(
//       id: '2',
//       title: 'انطلاق فعاليات الأسبوع العلمي للكلية',
//       content: 'انطلقت فعاليات الأسبوع العلمي السنوي لكلية الحاسبات والمعلومات بمشاركة واسعة من الطلاب والأساتذة',
//       mainImage: 'https://via.placeholder.com/600x400.png?text=News+2',
//       images: const [],
//       type: 'event',
//       createdAt: DateTime(2024, 10, 15),
//       updatedAt: DateTime(2024, 10, 15),
//     ),
//     NewsModel(
//       id: '3',
//       title: 'توقيع اتفاقية تعاون مع شركة تقنية رائدة',
//       content: 'تم توقيع اتفاقية تعاون بين الكلية وشركة تقنية رائدة في مجال الذكاء الاصطناعي وتطوير البرمجيات',
//       mainImage: 'https://via.placeholder.com/600x400.png?text=News+3',
//       images: const [],
//       type: 'news',
//       createdAt: DateTime(2024, 10, 12),
//       updatedAt: DateTime(2024, 10, 12),
//     ),
//     NewsModel(
//       id: '4',
//       title: 'حفل تخرج الدفعة الجديدة من الطلاب',
//       content: 'تم الاحتفال بتخرج الدفعة الجديدة من طلاب كلية الحاسبات والمعلومات بحضور الأهل والأساتذة',
//       mainImage: 'https://via.placeholder.com/600x400.png?text=News+4',
//       images: const [],
//       type: 'graduation',
//       createdAt: DateTime(2024, 10, 10),
//       updatedAt: DateTime(2024, 10, 10),
//     ),
//     NewsModel(
//       id: '5',
//       title: 'إطلاق برنامج الماجستير في الذكاء الاصطناعي',
//       content: 'أعلنت الكلية عن إطلاق برنامج الماجستير الجديد في الذكاء الاصطناعي والتعلم الآلي',
//       mainImage: 'https://via.placeholder.com/600x400.png?text=News+5',
//       images: const [],
//       type: 'program',
//       createdAt: DateTime(2024, 10, 8),
//       updatedAt: DateTime(2024, 10, 8),
//     ),
//     NewsModel(
//       id: '6',
//       title: 'ورشة عمل حول الأمن السيبراني',
//       content: 'نظمت الكلية ورشة عمل متخصصة حول الأمن السيبراني وأهميته في حماية البيانات والمعلومات',
//       mainImage: 'https://via.placeholder.com/600x400.png?text=News+6',
//       images: const [],
//       type: 'workshop',
//       createdAt: DateTime(2024, 10, 5),
//       updatedAt: DateTime(2024, 10, 5),
//     ),
//     NewsModel(
//       id: '7',
//       title: 'فوز فريق الكلية في مسابقة البرمجة الوطنية',
//       content: 'فاز فريق الكلية بالمركز الأول في مسابقة البرمجة الوطنية التي أقيمت في القاهرة',
//       mainImage: 'https://via.placeholder.com/600x400.png?text=News+7',
//       images: const [],
//       type: 'achievement',
//       createdAt: DateTime(2024, 10, 3),
//       updatedAt: DateTime(2024, 10, 3),
//     ),
//     NewsModel(
//       id: '8',
//       title: 'محاضرة حول مستقبل التكنولوجيا',
//       content: 'أقيمت محاضرة علمية حول مستقبل التكنولوجيا وتأثيرها على المجتمع والاقتصاد',
//       mainImage: 'https://via.placeholder.com/600x400.png?text=News+8',
//       images: const [],
//       type: 'lecture',
//       createdAt: DateTime(2024, 10, 1),
//       updatedAt: DateTime(2024, 10, 1),
//     ),
//     NewsModel(
//       id: '9',
//       title: 'افتتاح معمل الحاسوب الجديد',
//       content: 'تم افتتاح معمل الحاسوب الجديد المجهز بأحدث التقنيات والمعدات التعليمية',
//       mainImage: 'https://via.placeholder.com/600x400.png?text=News+9',
//       images: const [],
//       type: 'facility',
//       createdAt: DateTime(2024, 9, 28),
//       updatedAt: DateTime(2024, 9, 28),
//     ),
//     NewsModel(
//       id: '10',
//       title: 'ندوة حول التطوير المهني في مجال التقنية',
//       content: 'نظمت الكلية ندوة حول التطوير المهني في مجال التقنية ومتطلبات سوق العمل',
//       mainImage: 'https://via.placeholder.com/600x400.png?text=News+10',
//       images: const [],
//       type: 'seminar',
//       createdAt: DateTime(2024, 9, 25),
//       updatedAt: DateTime(2024, 9, 25),
//     ),
//   ];
//
//   // الحصول على جميع الأخبار
//   static List<NewsModel> getAllNews() {
//     return List.from(_newsList);
//   }
//
//   // الحصول على الأخبار المهمة فقط
//   static List<NewsModel> getImportantNews() {
//     // ليس لدينا مفتاح isImportant في الموديل الجديد؛ يمكن التعديل لاحقاً
//     return List.from(_newsList);
//   }
//
//   // الحصول على آخر 3 أخبار
//   static List<NewsModel> getLatestNews({int count = 3}) {
//     final sortedNews = List<NewsModel>.from(_newsList);
//     sortedNews.sort((a, b) {
//       if (a.createdAt == null && b.createdAt == null) return 0;
//       if (a.createdAt == null) return 1;
//       if (b.createdAt == null) return -1;
//       return b.createdAt!.compareTo(a.createdAt!);
//     });
//     return sortedNews.take(count).toList();
//   }
//
//   // الحصول على أخبار حسب الفئة
//   static List<NewsModel> getNewsByCategory(String category) {
//     // باستخدام الحقل type كبديل مبسط للتصنيف
//     return _newsList.where((news) => news.type == category).toList();
//   }
//
//   // البحث في الأخبار
//   static List<NewsModel> searchNews(String query) {
//     if (query.isEmpty) return getAllNews();
//
//     return _newsList.where((news) {
//       return news.title.toLowerCase().contains(query.toLowerCase()) ||
//              news.content.toLowerCase().contains(query.toLowerCase()) ||
//              news.type.toLowerCase().contains(query.toLowerCase());
//     }).toList();
//   }
//
//   // الحصول على خبر محدد بالـ ID
//   static NewsModel? getNewsById(String id) {
//     try {
//       return _newsList.firstWhere((news) => news.id == id);
//     } catch (e) {
//       return null;
//     }
//   }
//
//   // الحصول على جميع الفئات المتاحة
//   static List<String> getAllCategories() {
//     final categories = _newsList
//         .map((news) => news.type)
//         .toSet()
//         .toList();
//     categories.sort();
//     return categories;
//   }
//
//   // إضافة خبر جديد (للاستخدام المستقبلي مع API)
//   static void addNews(NewsModel news) {
//     _newsList.insert(0, news);
//   }
//
//   // تحديث خبر موجود
//   static bool updateNews(NewsModel updatedNews) {
//     final index = _newsList.indexWhere((news) => news.id == updatedNews.id);
//     if (index != -1) {
//       _newsList[index] = updatedNews;
//       return true;
//     }
//     return false;
//   }
//
//   // حذف خبر
//   static bool deleteNews(String id) {
//     final index = _newsList.indexWhere((news) => news.id == id);
//     if (index != -1) {
//       _newsList.removeAt(index);
//       return true;
//     }
//     return false;
//   }
// }