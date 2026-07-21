import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/resources/data_state.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';
import 'package:news/feature/news/domain/usecases/news_usecases.dart';
import 'package:news/feature/news/presentation/bloc/top_news/top_news_event.dart';
import 'package:news/feature/news/presentation/bloc/top_news/top_news_state.dart';

class TopNewsBloc extends Bloc<TopNewsEvent, TopNewsState> {
  final GetNewsUseCase getNewsUseCase;

  TopNewsBloc(this.getNewsUseCase) : super(TopNewsLoading()) {
    on<GetTopNewsEvent>(_onGetTopNews);
  }

  Future<void> _onGetTopNews(
    GetTopNewsEvent event,
    Emitter<TopNewsState> emit,
  ) async {
    emit(TopNewsLoading());

    final result = await getNewsUseCase();
    // print(result.data);

    if (result is DataSuccess<List<NewsEntity>>) {
      emit(TopNewsLoaded(result.data ?? []));
    } else if (result is DataFailed) {
      emit(TopNewsError(result.error?.message ?? "Something went wrong"));
    }
  }
}
