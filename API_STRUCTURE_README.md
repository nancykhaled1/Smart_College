# API Structure for Smart College App

## Overview
This document describes the complete API structure implemented for the Smart College app, specifically for the news functionality.

## API Endpoint
- **Base URL**: `https://smartcollgeapp-production.up.railway.app`
- **News Endpoint**: `/api/user/news`

## API Response Format
```json
{
    "success": true,
    "data": [
        {
            "_id": "68c957e8155818e6fbfd9501",
            "title": "المكتبة الجديدة",
            "content": "تم افتتاح المكتبة الجديدة في كلية ...",
            "mainImage": "https://example.com/main.jpg",
            "images": [
                "https://example.com/image1.jpg",
                "https://example.com/image2.jpg"
            ],
            "optional": [
                "https://example.com/file.pdf"
            ],
            "type": "news",
            "createdAt": "2025-09-16T12:28:24.134Z",
            "updatedAt": "2025-09-16T12:28:24.134Z",
            "__v": 0
        }
    ]
}
```

## Project Structure

### 1. Models
- **`lib/Models/Request/NewsRequest.dart`** - Request model for creating/updating news
- **`lib/Models/Request/NewsSearchRequest.dart`** - Request model for search functionality
- **`lib/Models/Response/NewsListResponse.dart`** - Response model for news list
- **`lib/Models/Response/NewsError.dart`** - Error response model
- **`lib/Models/Response/news_model.dart`** - Updated to match API format

### 2. API Layer
- **`lib/services/remote/apiConstants.dart`** - API endpoints constants
- **`lib/services/remote/apiManager.dart`** - HTTP client with news methods

### 3. Data Sources
- **`lib/sources/NewsDataSource.dart`** - Remote data source for news

### 4. Repositories
- **`lib/Repositories/NewsRepository.dart`** - Repository pattern implementation

### 5. State Management
- **`lib/Cubits/News/NewsViewModel.dart`** - BLoC/Cubit for state management

### 6. Services
- **`lib/services/api_news_service.dart`** - High-level service for easy API usage

## Usage Examples

### 1. Using ApiNewsService (Recommended)
```dart
// Get latest news
List<NewsModel> news = await ApiNewsService.getLatestNews(count: 3);

// Get all news with pagination
List<NewsModel> allNews = await ApiNewsService.getAllNews(page: 1, limit: 10);

// Search news
List<NewsModel> searchResults = await ApiNewsService.searchNews(
  query: "مكتبة",
  category: "أخبار الجامعة"
);

// Get news by ID
NewsModel? newsItem = await ApiNewsService.getNewsById("68c957e8155818e6fbfd9501");
```

### 2. Using NewsViewModel (BLoC Pattern)
```dart
// In your widget
BlocProvider(
  create: (context) => NewsViewModel(NewsRepository(NewsRemoteDataSource(ApiManager()))),
  child: BlocBuilder<NewsViewModel, NewsState>(
    builder: (context, state) {
      if (state is NewsLoading) {
        return CircularProgressIndicator();
      } else if (state is NewsLoaded) {
        return ListView.builder(
          itemCount: state.news.length,
          itemBuilder: (context, index) {
            final news = state.news[index];
            return ListTile(
              title: Text(news.title),
              subtitle: Text(news.content),
              leading: Image.network(news.mainImage),
            );
          },
        );
      } else if (state is NewsErrorState) {
        return Text('Error: ${state.message}');
      }
      return Container();
    },
  ),
)

// Trigger loading
context.read<NewsViewModel>().loadLatestNews(count: 3);
```

### 3. Direct Repository Usage
```dart
final repository = NewsRepository(NewsRemoteDataSource(ApiManager()));
final result = await repository.getLatestNews(count: 3);

result.fold(
  (error) => print('Error: ${error.message}'),
  (response) => print('News: ${response.data}'),
);
```

## Key Features

### 1. Error Handling
- Network connectivity checks
- Proper error responses
- Fallback mechanisms

### 2. Pagination Support
- Page-based pagination
- Configurable limit
- Total count and pages information

### 3. Search Functionality
- Text-based search
- Category filtering
- Combined search and filter

### 4. Image Handling
- Network image loading
- Error fallbacks
- Multiple image support

### 5. State Management
- Loading states
- Error states
- Success states
- BLoC pattern implementation

## Integration with UI

The graduated home screen has been updated to use the new API structure:

```dart
// Load news in initState
Future<void> _loadNews() async {
  try {
    final news = await ApiNewsService.getLatestNews(count: 3);
    if (mounted) {
      setState(() {
        newsItems = news;
      });
    }
  } catch (e) {
    print('Error loading news: $e');
  }
}

// Display news with network images
Image.network(
  news.mainImage,
  errorBuilder: (context, error, stackTrace) {
    return Container(
      color: Colors.grey[300],
      child: Icon(Icons.image_not_supported),
    );
  },
)
```

## Future Enhancements

1. **Caching**: Implement local caching for offline support
2. **Real-time Updates**: Add WebSocket support for live news updates
3. **Image Optimization**: Implement image compression and lazy loading
4. **Analytics**: Add news view tracking and analytics
5. **Push Notifications**: Integrate with news notification system

## Dependencies

Make sure these packages are added to `pubspec.yaml`:

```yaml
dependencies:
  http: ^1.1.0
  dartz: ^0.10.1
  connectivity_plus: ^5.0.1
  flutter_bloc: ^8.1.3
```

This structure provides a robust, scalable foundation for API integration in your Flutter app.

