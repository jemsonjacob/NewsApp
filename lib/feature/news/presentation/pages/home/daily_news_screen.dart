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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (_) =>
              //           ArticleDetailsScreen(news: state.news[index]),
              //     ),
              //   );

              return Card(
                margin: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ArticleDetailsScreen(news: state.news[index]),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child:
                            (news.urlToImage != null &&
                                news.urlToImage!.isNotEmpty)
                            ? Image.network(
                                news.urlToImage!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Icon(Icons.broken_image),
                                    ),
                                  );
                                },
                              )
                            : const SizedBox(
                                height: 200,
                                child: Center(child: Icon(Icons.image)),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          news.title ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          news.description ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
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
