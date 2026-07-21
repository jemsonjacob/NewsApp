import 'package:news/core/resources/data_state.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';

abstract class NewsRepository {
  Future<DataState<List<NewsEntity>>> getNewsArticles();
  Future<DataState<List<NewsEntity>>> getNewsArticlesByCategory(
    String category,
  );
}
