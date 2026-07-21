import 'package:dio/dio.dart';
import 'package:news/core/constants/constants.dart';
import 'package:news/feature/news/data/models/news_model.dart';

// Abstract class defining how to fetch news from network
abstract class NewsRemoteDataSource {
  // Get all news from API
  Future<List<NewsModel>> getNews();
  // Get news for specific category
  Future<List<NewsModel>> getNewsByCategory(String category);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  // Dio instance for making HTTP requests
  final Dio dio;
  // Constructor: requires Dio instance
  NewsRemoteDataSourceImpl(this.dio);

  // Base URL
  //   'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=9bd05db1528c4adb8e8d11d0bfb0f43e';
  // final String _baseUrl =
  //     '$baseUrl/$categoryQuery?sources=$newsSource&apiKey=$newsAPIKey';
  // ============== METHOD 1: GET ALL NEWS ==============
  @override
  Future<List<NewsModel>> getNews() async {
    try {
      final response = await dio.get(
        '/top-headlines',
        queryParameters: {'country': 'in', 'apiKey': newsAPIKey},
      );

      final articles = response.data['articles'] as List;
      //print(articles);

      return articles
          .map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Unable to fetch news ,$e');
    }
  }

  @override
  Future<List<NewsModel>> getNewsByCategory(String category) async {
    try {
      final response = await dio.get(
        '/top-headlines',
        queryParameters: {
          'country': 'us',
          'category': category,
          'apiKey': newsAPIKey,
        },
      );
      // print(response.toString());
      final articles = (response.data['articles'] as List)
          .map((e) => NewsModel.fromJson(e))
          .toList();

      return articles;
    } on DioException catch (e) {
      throw Exception('Unable to fetch news ,$e');
    }
  }
}
