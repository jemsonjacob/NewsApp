import 'package:news/core/resources/data_state.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';

abstract class NewsRepository {
  //remote
  Future<DataState<List<NewsEntity>>> getNewsArticles();
  Future<DataState<List<NewsEntity>>> getNewsArticlesByCategory(
    String category,
  );

  //local
  Future<void> saveBookmark(NewsEntity article);

  Future<void> removeBookmark(String url);

  Future<List<NewsEntity>> getBookmarks();

  Future<bool> isBookmarked(String url);
}
