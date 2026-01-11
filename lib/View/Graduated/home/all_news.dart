import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_college/Models/Response/news_model.dart';
import 'package:smart_college/Models/Response/newsModel.dart';
import 'package:smart_college/utils/colors.dart';
import 'package:smart_college/Cubits/News/NewsCubit.dart';
import 'package:smart_college/Cubits/News/NewsStates.dart';
import 'package:smart_college/View/Graduated/home/news_datails.dart';
import 'package:smart_college/View/widgets/common_top_search_bar.dart';

class AllNews extends StatefulWidget {
  const AllNews({super.key});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  late TextEditingController _searchController;
  Timer? _debounceTimer;
  bool _isSearching = false;

  final List<String> _months = [
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<NewsCubit>().getNews();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text.trim();
      
      if (query.isEmpty) {
        setState(() => _isSearching = false);
        context.read<NewsCubit>().getNews();
      } else {
        setState(() => _isSearching = true);
        context.read<NewsCubit>().searchNews(query);
      }
    });
  }

  NewsModel _convertNewsToNewsModel(News news) {
    return NewsModel(
      title: news.title,
      content: news.content,
      mainImage: news.mainImage,
      images: news.images,
      createdAt: news.createdAt,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/Background.svg",
              fit: BoxFit.cover,
            ),
          ),
          
          // Search Bar
          Positioned(
  top: 50.h,
  left: 0,
  right: 0,
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
  
    child: Row(
      children: [
        // Back Button
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 39.w,
            height: 38.h,
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.circular(9),
             
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/back.svg",
                width: 8.w,
                height: 13.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        
        SizedBox(width: 12.w),
        
        // Search TextField
        Expanded(
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _searchController,
            builder: (context, value, child) {
              return TextField(
                controller: _searchController,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: 'ابحث عن الأخبار...',
                  hintStyle: TextStyle(
                    fontFamily: 'Noto Kufi Arabic',
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                  suffixIcon: Icon(Icons.search, color: Color(0xFF00BFA5)),
                  prefixIcon: value.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _isSearching = false;
                            });
                            context.read<NewsCubit>().getNews();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Noto Kufi Arabic',
                  fontSize: 14.sp,
                ),
              );
            },
          ),
        ),
      ],
    ),
  ),
),
          // News List
          Positioned(
            top: 110.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: BlocBuilder<NewsCubit, NewsStates>(
              builder: (context, state) {
                return _buildContent(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(NewsStates state) {
    // Handle search states
    if (_isSearching) {
      if (state is NewsSearchLoadingState) {
        return _buildLoadingIndicator();
      } else if (state is NewsSearchErrorState) {
        return _buildErrorWidget(
          state.errorMessage ?? "حدث خطأ",
          () => context.read<NewsCubit>().searchNews(_searchController.text.trim()),
        );
      } else if (state is NewsSearchSuccessState) {
        if (state.response.data.isEmpty) {
          return _buildEmptyState("لا توجد نتائج للبحث");
        }
        return _buildNewsList(state.response.data);
      }
      return const SizedBox.shrink();
    }

    // Handle regular states
    if (state is NewsLoadingState) {
      return _buildLoadingIndicator();
    } else if (state is NewsErrorState) {
      return _buildErrorWidget(
        state.errorMessage ?? "حدث خطأ",
        () => context.read<NewsCubit>().getNews(),
      );
    } else if (state is NewsSuccessState) {
      if (state.response.data.isEmpty) {
        return _buildEmptyState("لا توجد أخبار متاحة");
      }
      return _buildNewsList(state.response.data);
    }

    return const SizedBox.shrink();
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.primaryColor,
      ),
    );
  }

  Widget _buildErrorWidget(String message, VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 50),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: "Noto Kufi Arabic",
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15.h),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text(
              "إعادة المحاولة",
              style: TextStyle(
                fontFamily: "Noto Kufi Arabic",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.newspaper_outlined,
            size: 60,
            color: Colors.grey,
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
              fontFamily: "Noto Kufi Arabic",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList(List<News> newsList) {
    final newsModelList = newsList.map(_convertNewsToNewsModel).toList();
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final newsModel = newsModelList[index];
        return _buildNewsCard(newsModel, newsModelList, index, newsList);
      },
    );
  }

  Widget _buildNewsCard(NewsModel newsModel, List<NewsModel> allNewsModels, int index, List<News> originalNewsList) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Content section (right side for RTL)
              // Image section (left side for RTL)
            _buildNewsImage(newsModel.mainImage),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Text(
                      newsModel.title,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Noto Kufi Arabic",
                        color: MyColors.softBlackColor,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 8.h),
                    
                    // Content
                    Text(
                      newsModel.content,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Noto Kufi Arabic",
                        color: MyColors.greyColor,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 12.h),
                    
                    // Date and "View More" button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Date
                        Flexible(
                          child: Text(
                            _formatDate(newsModel.createdAt),
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Noto Kufi Arabic",
                              color: const Color(0xffAAAAAB),
                            ),
                          ),
                        ),
                        
                        // View More button
                        GestureDetector(
                          onTap: () => _navigateToDetails(originalNewsList, index),
                          child: Text(
                            "عرض المزيد",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Noto Kufi Arabic",
                              color: MyColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
          
          ],
        ),
      ),
    );
  }

  Widget _buildNewsImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      ),
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              width: 120.w,
              height: 120.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _buildImagePlaceholder();
              },
            )
          : _buildImagePlaceholder(),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Icon(
        Icons.image_not_supported,
        size: 40,
        color: Colors.grey[500],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "تاريخ غير متاح";
    return "${date.day} ${_months[date.month - 1]}, ${date.year}";
  }

  void _navigateToDetails(List<News> newsList, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetails(
          news: newsList[index],
        ),
      ),
    );
  }
}