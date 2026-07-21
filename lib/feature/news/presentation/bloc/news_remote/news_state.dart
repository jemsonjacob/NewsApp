part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState({this.news = const [], this.message = ''});

  final String? message;
  final List<NewsEntity> news;

  @override
  List<Object?> get props => [news, message];
}

//initial state
class NewsInitial extends NewsState {
  const NewsInitial();
}

//when requesting data to server & waiting for the data
class NewsLoading extends NewsState {
  const NewsLoading();
}

//when data has returned & need to show it in UI
class NewsLoaded extends NewsState {
  const NewsLoaded(List<NewsEntity> news) : super(news: news);
}

//when error occurs
class NewsError extends NewsState {
  const NewsError(String message) : super(message: message);
}
