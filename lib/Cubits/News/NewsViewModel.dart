import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Models/Response/news_model.dart';
import 'package:smart_college/Repositories/NewsRepository.dart';

// Events
abstract class NewsEvent {
  const NewsEvent();
}

class LoadAllNews extends NewsEvent {
  final int page;
  final int limit;

  const LoadAllNews({this.page = 1, this.limit = 10});
}

class LoadLatestNews extends NewsEvent {
  final int count;

  const LoadLatestNews({this.count = 3});
}

class LoadNewsById extends NewsEvent {
  final String id;

  const LoadNewsById(this.id);
}

class SearchNews extends NewsEvent {
  final String? query;
  final String? category;
  final int page;
  final int limit;

  const SearchNews({
    this.query,
    this.category,
    this.page = 1,
    this.limit = 10,
  });
}

class LoadNewsByCategory extends NewsEvent {
  final String category;
  final int page;
  final int limit;

  const LoadNewsByCategory({
    required this.category,
    this.page = 1,
    this.limit = 10,
  });
}

class LoadNewsCategories extends NewsEvent {}

// States
abstract class NewsState {
  const NewsState();
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> news;
  final int? totalCount;
  final int? currentPage;
  final int? totalPages;

  const NewsLoaded({
    required this.news,
    this.totalCount,
    this.currentPage,
    this.totalPages,
  });
}

class NewsDetailLoaded extends NewsState {
  final NewsModel news;

  const NewsDetailLoaded(this.news);
}

class NewsCategoriesLoaded extends NewsState {
  final List<String> categories;

  const NewsCategoriesLoaded(this.categories);
}

class NewsErrorState extends NewsState {
  final String message;

  const NewsErrorState(this.message);
}

// Cubit
class NewsViewModel extends Cubit<NewsState> {
  final NewsRepository newsRepository;

  NewsViewModel(this.newsRepository) : super(NewsInitial());

  Future<void> loadAllNews({int page = 1, int limit = 10}) async {
    emit(NewsLoading());
    
    final result = await newsRepository.getAllNews(page: page, limit: limit);
    
    result.fold(
      (error) => emit(NewsErrorState(error.message)),
      (response) => emit(NewsLoaded(
        news: response.data,
        totalCount: response.totalCount,
        currentPage: response.currentPage,
        totalPages: response.totalPages,
      )),
    );
  }

  Future<void> loadLatestNews({int count = 3}) async {
    emit(NewsLoading());
    
    final result = await newsRepository.getLatestNews(count: count);
    
    result.fold(
      (error) => emit(NewsErrorState(error.message)),
      (response) => emit(NewsLoaded(
        news: response.data,
        totalCount: response.totalCount,
        currentPage: response.currentPage,
        totalPages: response.totalPages,
      )),
    );
  }

  Future<void> loadNewsById(String id) async {
    emit(NewsLoading());
    
    final result = await newsRepository.getNewsById(id);
    
    result.fold(
      (error) => emit(NewsErrorState(error.message)),
      (news) => emit(NewsDetailLoaded(news)),
    );
  }

  Future<void> searchNews({
    String? query,
    String? category,
    int page = 1,
    int limit = 10,
  }) async {
    emit(NewsLoading());
    
    final result = await newsRepository.searchNews(
      query: query,
      category: category,
      page: page,
      limit: limit,
    );
    
    result.fold(
      (error) => emit(NewsErrorState(error.message)),
      (response) => emit(NewsLoaded(
        news: response.data,
        totalCount: response.totalCount,
        currentPage: response.currentPage,
        totalPages: response.totalPages,
      )),
    );
  }

  Future<void> loadNewsByCategory({
    required String category,
    int page = 1,
    int limit = 10,
  }) async {
    emit(NewsLoading());
    
    final result = await newsRepository.getNewsByCategory(
      category,
      page: page,
      limit: limit,
    );
    
    result.fold(
      (error) => emit(NewsErrorState(error.message)),
      (response) => emit(NewsLoaded(
        news: response.data,
        totalCount: response.totalCount,
        currentPage: response.currentPage,
        totalPages: response.totalPages,
      )),
    );
  }

  Future<void> loadNewsCategories() async {
    emit(NewsLoading());
    
    final result = await newsRepository.getNewsCategories();
    
    result.fold(
      (error) => emit(NewsErrorState(error.message)),
      (categories) => emit(NewsCategoriesLoaded(categories)),
    );
  }
}
