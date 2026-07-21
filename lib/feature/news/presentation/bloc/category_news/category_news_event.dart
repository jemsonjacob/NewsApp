import 'package:equatable/equatable.dart';

abstract class CategoryNewsEvent extends Equatable {
  const CategoryNewsEvent();

  @override
  List<Object?> get props => [];
}

class GetCategoryNewsEvent extends CategoryNewsEvent {
  final String category;

  const GetCategoryNewsEvent(this.category);

  @override
  List<Object?> get props => [category];
}
