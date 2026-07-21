import 'package:equatable/equatable.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';

abstract class TopNewsState extends Equatable {
  const TopNewsState();

  @override
  List<Object?> get props => [];
}

class TopNewsLoading extends TopNewsState {}

class TopNewsLoaded extends TopNewsState {
  final List<NewsEntity> news;

  const TopNewsLoaded(this.news);

  @override
  List<Object?> get props => [news];
}

class TopNewsError extends TopNewsState {
  final String message;

  const TopNewsError(this.message);

  @override
  List<Object?> get props => [message];
}
