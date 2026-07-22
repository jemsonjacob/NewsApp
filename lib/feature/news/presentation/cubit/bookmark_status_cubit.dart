import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';
import 'package:news/feature/news/domain/usecases/news_usecases.dart';

class BookmarkStatusCubit extends Cubit<bool> {
  final SaveBookmarkUseCase saveBookmarkUseCase;
  final RemoveBookmarkUseCase removeBookmarkUseCase;
  final IsBookmarkedUseCase isBookmarkedUseCase;

  BookmarkStatusCubit({
    required this.saveBookmarkUseCase,
    required this.removeBookmarkUseCase,
    required this.isBookmarkedUseCase,
  }) : super(false);

  Future<void> checkBookmark(String url) async {
    final bookmarked = await isBookmarkedUseCase(params: url);
    emit(bookmarked);
  }

  Future<void> addBookmark(NewsEntity article) async {
    await saveBookmarkUseCase(params: article);
    emit(true);
  }

  Future<void> removeBookmark(String url) async {
    await removeBookmarkUseCase(params: url);
    emit(false);
  }
}
