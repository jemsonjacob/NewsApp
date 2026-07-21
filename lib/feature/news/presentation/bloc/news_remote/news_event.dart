import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

//event to fetch news
class GetNewsEvent extends NewsEvent {
  const GetNewsEvent();
}

class GetCategoryNewsEvent extends NewsEvent {
  final String category;

  const GetCategoryNewsEvent(this.category);

  @override
  List<Object> get props => [category];
}
