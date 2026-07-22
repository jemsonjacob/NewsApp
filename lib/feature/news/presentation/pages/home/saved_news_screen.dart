import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/feature/news/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:news/feature/news/presentation/bloc/bookmark/bookmark_event.dart';
import 'package:news/feature/news/presentation/bloc/bookmark/bookmark_state.dart';
import 'package:news/feature/news/presentation/pages/home/news_details_screen.dart';
import 'package:news/feature/news/presentation/widgets/news_tiles.dart';

class SavedNewsScreen extends StatefulWidget {
  const SavedNewsScreen({super.key});

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  @override
  void initState() {
    context.read<BookmarkBloc>().add(LoadBookmarksEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return BlocBuilder<BookmarkBloc, BookmarksState>(
      builder: (context, state) {
        if (state is BookmarkLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BookmarkLoaded) {
          return ListView.builder(
            itemCount: state.news.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ArticleDetailsScreen(news: state.news[index]),
                    ),
                  );
                },
                child: NewsTile(article: state.news[index]),
              );
            },
          );
        }

        if (state is BookmarkError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
