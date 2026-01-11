import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Cubits/News/NewsStates.dart';
import 'package:smart_college/Repositories/NewsRepository.dart';

class NewsCubit extends Cubit<NewsStates> {
  final NewsRepository repository;

  NewsCubit(this.repository) : super(NewsInitialState());

  Future<void> getNews() async {
    emit(NewsLoadingState(loadingMessage: "جاري تحميل الأخبار..."));
    
    final response = await repository.getNews();
    
    response.fold(
      (error) {
        emit(NewsErrorState(
          errorMessage: error.error?.message ?? "حدث خطأ أثناء تحميل الأخبار",
        ));
      },
      (newsResponse) {
        emit(NewsSuccessState(response: newsResponse));
      },
    );
  }

  /// Get news details by ID
  Future<void> getNewsById(String id) async {
    emit(NewsDetailLoadingState(loadingMessage: "جاري تحميل تفاصيل الخبر..."));
    
    final response = await repository.getNewsById(id);
    
    response.fold(
      (error) {
        emit(NewsDetailErrorState(
          errorMessage: error.error?.message ?? "حدث خطأ أثناء تحميل تفاصيل الخبر",
        ));
      },
      (newsDetailResponse) {
        emit(NewsDetailSuccessState(response: newsDetailResponse));
      },
    );
  }

  /// Search news by query
  Future<void> searchNews(String query) async {
    if (query.trim().isEmpty) {
      // If query is empty, get all news
      getNews();
      return;
    }

    emit(NewsSearchLoadingState(loadingMessage: "جاري البحث عن الأخبار..."));

    final response = await repository.searchNews(query.trim());

    response.fold(
      (error) {
        emit(NewsSearchErrorState(
          errorMessage: error.error?.message ?? "حدث خطأ أثناء البحث عن الأخبار",
        ));
      },
      (newsResponse) {
        emit(NewsSearchSuccessState(response: newsResponse));
      },
    );
  }
}

