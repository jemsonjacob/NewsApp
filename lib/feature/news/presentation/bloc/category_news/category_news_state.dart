import 'package:equatable/equatable.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';

abstract class CategoryNewsState extends Equatable {
  const CategoryNewsState();

  @override
  List<Object?> get props => [];
}

class CategoryNewsLoading extends CategoryNewsState {}

class CategoryNewsLoaded extends CategoryNewsState {
  final List<NewsEntity> news;

  const CategoryNewsLoaded(this.news);

  @override
  List<Object?> get props => [news];
}

class CategoryNewsError extends CategoryNewsState {
  final String message;

  const CategoryNewsError(this.message);

  @override
  List<Object?> get props => [message];
}
