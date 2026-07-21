import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/resources/data_state.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';
import 'package:news/feature/news/domain/usecases/news_usecases.dart';
import 'package:news/feature/news/presentation/bloc/category_news/category_news_event.dart';
import 'package:news/feature/news/presentation/bloc/category_news/category_news_state.dart';

class CategoryNewsBloc extends Bloc<CategoryNewsEvent, CategoryNewsState> {
  final GetCategoryNewsUseCase getCategoryNewsUseCase;

  CategoryNewsBloc(this.getCategoryNewsUseCase) : super(CategoryNewsLoading()) {
    on<GetCategoryNewsEvent>(_onGetCategoryNews);
  }

  Future<void> _onGetCategoryNews(
    GetCategoryNewsEvent event,
    Emitter<CategoryNewsState> emit,
  ) async {
    emit(CategoryNewsLoading());

    final dataState = await getCategoryNewsUseCase(params: event.category);

    if (dataState is DataSuccess<List<NewsEntity>>) {
      emit(CategoryNewsLoaded(dataState.data!));
    }

    if (dataState is DataFailed<List<NewsEntity>>) {
      emit(
        CategoryNewsError(dataState.error?.message ?? "Something went wrong"),
      );
    }
  }
}
