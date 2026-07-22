import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news/feature/news/data/models/bookmark_model.dart';
import 'package:news/feature/news/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:news/feature/news/presentation/bloc/category_news/category_news_bloc.dart';
import 'package:news/feature/news/presentation/bloc/top_news/top_news_bloc.dart';
import 'package:news/feature/news/presentation/cubit/bookmark_status_cubit.dart';
import 'package:news/feature/news/presentation/pages/home/main_screen.dart';
import 'package:news/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(BookmarkModelAdapter());

  await Hive.openBox<BookmarkModel>('bookmarks');
  //registers Hive.box<BookmarkModel>('bookmarks')
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<TopNewsBloc>()),
        BlocProvider(create: (_) => sl<CategoryNewsBloc>()),
        BlocProvider(create: (_) => sl<BookmarkBloc>()),
        BlocProvider(create: (_) => sl<BookmarkStatusCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MainScreen(),
      ),
    );
  }
}
