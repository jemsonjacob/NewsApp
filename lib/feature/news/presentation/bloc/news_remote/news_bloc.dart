import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/resources/data_state.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';
import 'package:news/feature/news/domain/usecases/news_usecases.dart';
import 'package:news/feature/news/presentation/bloc/news_remote/news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  // ============== CONSTRUCTOR ==============
  NewsBloc(this.getNewsUseCase) : super(const NewsInitial()) {
    // super(const NewsInitial()) = initial state when app starts

    // ============== REGISTER EVENT HANDLERS ==============
    // When FetchNewssEvent arrives, call _onFetchNewss
    on<GetNewsEvent>(_onGetNews);
  }

  // ============== DEPENDENCIES ==============
  // Inject both use cases
  final GetNewsUseCase getNewsUseCase;

  // Called when FetchNewssEvent is received
  Future<void> _onGetNews(GetNewsEvent event, Emitter<NewsState> emit) async {
    emit(const NewsLoading());

    final result = await getNewsUseCase();

    if (result is DataSuccess<List<NewsEntity>>) {
      emit(NewsLoaded(result.data ?? []));
    } else if (result is DataFailed) {
      emit(NewsError(result.error?.message ?? "Something went wrong"));
    }
  }
}
