import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news/core/constants/constants.dart';
import 'package:news/feature/news/data/data_sources/remote/news_remote_datasource.dart';
import 'package:news/feature/news/data/repositories_impli/news_repository_impli.dart';
import 'package:news/feature/news/domain/repositories/news_repository.dart';
import 'package:news/feature/news/domain/usecases/news_usecases.dart';
import 'package:news/feature/news/presentation/bloc/category_news/category_news_bloc.dart';
import 'package:news/feature/news/presentation/bloc/top_news/top_news_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //register dio
  sl.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );
  //register datasource
  sl.registerSingleton<NewsRemoteDataSource>(NewsRemoteDataSourceImpl(sl()));
  //register repository
  sl.registerSingleton<NewsRepository>(NewsRepositoryImpli(sl()));
  //register usecase
  sl.registerSingleton<GetNewsUseCase>(GetNewsUseCase(sl()));
  sl.registerSingleton<GetCategoryNewsUseCase>(GetCategoryNewsUseCase(sl()));
  //register bloc
  sl.registerFactory<TopNewsBloc>(() => TopNewsBloc(sl()));

  sl.registerFactory<CategoryNewsBloc>(() => CategoryNewsBloc(sl()));
}
