import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:news/core/constants/constants.dart';
import 'package:news/feature/news/data/data_sources/local/bookmark_local_datsource.dart';
import 'package:news/feature/news/data/data_sources/remote/news_remote_datasource.dart';
import 'package:news/feature/news/data/models/bookmark_model.dart';
import 'package:news/feature/news/data/repositories_impli/news_repository_impli.dart';
import 'package:news/feature/news/domain/repositories/news_repository.dart';
import 'package:news/feature/news/domain/usecases/news_usecases.dart';
import 'package:news/feature/news/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:news/feature/news/presentation/bloc/category_news/category_news_bloc.dart';
import 'package:news/feature/news/presentation/bloc/top_news/top_news_bloc.dart';
import 'package:news/feature/news/presentation/cubit/bookmark_status_cubit.dart';

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
  //register hive
  sl.registerSingleton<Box<BookmarkModel>>(
    Hive.box<BookmarkModel>('bookmarks'),
  );
  //register remote datasource
  sl.registerSingleton<NewsRemoteDataSource>(NewsRemoteDataSourceImpl(sl()));
  //registe local datsource
  sl.registerSingleton<BookmarkLocalDatasource>(
    BookmarkLocalDatasourceImpl(sl<Box<BookmarkModel>>()),
  );

  //register repository
  sl.registerSingleton<NewsRepository>(
    NewsRepositoryImpli(
      sl<NewsRemoteDataSource>(),
      sl<BookmarkLocalDatasource>(),
    ),
  );
  //register usecase
  sl.registerSingleton<GetNewsUseCase>(GetNewsUseCase(sl()));
  sl.registerSingleton<GetCategoryNewsUseCase>(GetCategoryNewsUseCase(sl()));

  //local
  sl.registerSingleton<SaveBookmarkUseCase>(SaveBookmarkUseCase(sl()));

  sl.registerSingleton<RemoveBookmarkUseCase>(RemoveBookmarkUseCase(sl()));

  sl.registerSingleton<GetBookmarksUseCase>(GetBookmarksUseCase(sl()));

  sl.registerSingleton<IsBookmarkedUseCase>(IsBookmarkedUseCase(sl()));

  //register bloc
  sl.registerFactory<TopNewsBloc>(() => TopNewsBloc(sl()));

  sl.registerFactory<CategoryNewsBloc>(() => CategoryNewsBloc(sl()));

  sl.registerFactory<BookmarkBloc>(
    () => BookmarkBloc(getBookmarksUseCase: sl()),
  );

  sl.registerFactory<BookmarkStatusCubit>(
    () => BookmarkStatusCubit(
      saveBookmarkUseCase: sl(),
      removeBookmarkUseCase: sl(),
      isBookmarkedUseCase: sl(),
    ),
  );
}
