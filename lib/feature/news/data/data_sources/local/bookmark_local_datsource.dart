// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:news/feature/news/data/models/bookmark_model.dart';

abstract class BookmarkLocalDatasource {
  Future<void> saveBookmark(BookmarkModel article);

  Future<void> deleteBookmark(String url);

  List<BookmarkModel> getBookmarks();

  bool isBookmarked(String url);
}

// implementation
class BookmarkLocalDatasourceImpl implements BookmarkLocalDatasource {
  final Box<BookmarkModel> box;
  BookmarkLocalDatasourceImpl(this.box);

  @override
  Future<void> deleteBookmark(String url) async {
    await box.delete(url);
  }

  @override
  List<BookmarkModel> getBookmarks() {
    return box.values.toList();
  }

  @override
  bool isBookmarked(String url) {
    return box.containsKey(url);
  }

  @override
  Future<void> saveBookmark(BookmarkModel article) async {
    print("Before save: ${box.length}");

    await box.put(article.url, article); //key,value

    print("After save: ${box.length}");
  }
}
