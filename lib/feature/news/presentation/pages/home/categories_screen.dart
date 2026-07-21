import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/feature/news/presentation/bloc/category_news/category_news_bloc.dart';
import 'package:news/feature/news/presentation/bloc/category_news/category_news_event.dart';
import 'package:news/feature/news/presentation/bloc/category_news/category_news_state.dart';
import 'package:news/feature/news/presentation/pages/home/news_details_screen.dart';
import 'package:news/feature/news/presentation/widgets/news_tiles.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<String> categories = [
    "business",
    "sports",
    "technology",
    "health",
    "science",
    "entertainment",
  ];

  String selectedCategory = "business";

  @override
  void initState() {
    super.initState();

    context.read<CategoryNewsBloc>().add(
      GetCategoryNewsEvent(selectedCategory),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // Category Chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(category.toUpperCase()),
                    selected: selectedCategory == category,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });

                      context.read<CategoryNewsBloc>().add(
                        GetCategoryNewsEvent(category),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: BlocBuilder<CategoryNewsBloc, CategoryNewsState>(
              builder: (context, state) {
                if (state is CategoryNewsLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }

                if (state is CategoryNewsError) {
                  return Center(child: Text(state.message));
                }

                if (state is CategoryNewsLoaded) {
                  return ListView.builder(
                    itemCount: state.news.length,
                    itemBuilder: (context, index) {
                      final article = state.news[index];

                      return NewsTile(
                        article: article,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ArticleDetailsScreen(news: article),
                            ),
                          );
                        },
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
