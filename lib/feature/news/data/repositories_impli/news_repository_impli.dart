// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:news/core/resources/data_state.dart';
import 'package:news/feature/news/data/data_sources/local/bookmark_local_datsource.dart';
import 'package:news/feature/news/data/data_sources/remote/news_remote_datasource.dart';
import 'package:news/feature/news/data/models/bookmark_model.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';
import 'package:news/feature/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpli implements NewsRepository {
  NewsRepositoryImpli(this.remoteDataSource, this.localDatasource);

  final NewsRemoteDataSource remoteDataSource;

  final BookmarkLocalDatasource localDatasource;

  //remote
  @override
  Future<DataState<List<NewsEntity>>> getNewsArticles() async {
    try {
      final articles = await remoteDataSource.getNews();

      return DataSuccess(articles);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<NewsEntity>>> getNewsArticlesByCategory(
    String category,
  ) async {
    try {
      final articles = await remoteDataSource.getNewsByCategory(category);

      return DataSuccess(articles);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  //local
  @override
  Future<List<NewsEntity>> getBookmarks() async {
    final bookmarks = localDatasource.getBookmarks(); //bookmark model
    //covert to news entity
    return bookmarks.map((bookmark) => bookmark.toEntity()).toList();
  }

  @override
  Future<bool> isBookmarked(String url) async {
    return localDatasource.isBookmarked(url);
  }

  @override
  Future<void> removeBookmark(String url) async {
    await localDatasource.deleteBookmark(url);
  }

  @override
  Future<void> saveBookmark(NewsEntity article) async {
    //news entity
    final bookmark = BookmarkModel.fromEntity(article);

    await localDatasource.saveBookmark(bookmark);
  }
}
