// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:news/feature/news/domain/entities/news_entities.dart';

abstract class BookmarksState extends Equatable {
  const BookmarksState();

  @override
  List<Object?> get props => [];
}

class BookmarkLoading extends BookmarksState {}

class BookmarkLoaded extends BookmarksState {
  final List<NewsEntity> news;
  const BookmarkLoaded(this.news);

  @override
  List<Object?> get props => [news];
}

class BookmarkError extends BookmarksState {
  final String message;

  const BookmarkError(this.message);

  @override
  List<Object?> get props => [message];
}
