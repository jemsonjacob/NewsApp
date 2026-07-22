import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/feature/news/domain/usecases/news_usecases.dart';
import 'package:news/feature/news/presentation/bloc/bookmark/bookmark_event.dart';
import 'package:news/feature/news/presentation/bloc/bookmark/bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarksEvent, BookmarksState> {
  final GetBookmarksUseCase getBookmarksUseCase;

  BookmarkBloc({required this.getBookmarksUseCase}) : super(BookmarkLoading()) {
    // register event handlers

    on<LoadBookmarksEvent>(_onLoadBookmarks);
  }

  Future<void> _onLoadBookmarks(
    LoadBookmarksEvent event,
    Emitter<BookmarksState> emit,
  ) async {
    try {
      emit(BookmarkLoading());

      final bookmarks = await getBookmarksUseCase();
      print(bookmarks.length);
      emit(BookmarkLoaded(bookmarks));
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      emit(BookmarkError(e.toString()));
    }
  }
}
