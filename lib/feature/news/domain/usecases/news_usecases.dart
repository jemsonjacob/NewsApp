// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:news/core/resources/data_state.dart';
import 'package:news/core/usecases/usecase.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';
import 'package:news/feature/news/domain/repositories/news_repository.dart';

//A UseCase represents one business action.
// Bloc->NewsUsecases.call()-> NewsRepository.getNewsArticles()->RemoteDataSource.getNews()
//   -> HTTP Request-> DataSuccess(List<NewsEntity>)or DataFailed(Exception)
// -> Bloc emits states-> UI rebuilds

class GetNewsUseCase implements Usecase<DataState<List<NewsEntity>>, void> {
  GetNewsUseCase(this._newsRepository);

  final NewsRepository _newsRepository;

  @override
  Future<DataState<List<NewsEntity>>> call({void params}) async {
    //classes with a call() method can be invoked like a function
    return await _newsRepository.getNewsArticles();
  }
}
