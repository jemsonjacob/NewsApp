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
