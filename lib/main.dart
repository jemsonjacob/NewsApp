import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/feature/news/presentation/bloc/category_news/category_news_bloc.dart';
import 'package:news/feature/news/presentation/bloc/top_news/top_news_bloc.dart';
import 'package:news/feature/news/presentation/pages/home/main_screen.dart';
import 'package:news/injection_container.dart';

Future<void> main() async {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News',
        theme: ThemeData(
          // This is the theme of your application.
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MainScreen(),
      ),
    );
  }
}
