import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/feature/news/presentation/bloc/news_remote/news_bloc.dart';
import 'package:news/feature/news/presentation/bloc/news_remote/news_event.dart';
import 'package:news/feature/news/presentation/pages/home/news_details_screen.dart';

class DailyNewsScreen extends StatelessWidget {
  const DailyNewsScreen({super.key});

  Widget _buildBody() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is NewsLoaded) {
          return ListView.builder(
            itemCount: state.news.length,
            itemBuilder: (context, index) {
              final news = state.news[index];

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
                child: ListTile(
                  leading: news.urlToImage != null
                      ? Image.network(
                          news.urlToImage!,
                          width: 80,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image),
                  title: Text(
                    news.title ?? "No Title",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  subtitle: Text(
                    news.description ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        }
        if (state is NewsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline),
                const SizedBox(height: 12),
                Text(state.message ?? "Something went wrong"),
                ElevatedButton(
                  onPressed: () {
                    context.read<NewsBloc>().add(const GetNewsEvent());
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daily News")),
      body: _buildBody(),
    );
  }
}
