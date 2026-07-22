import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';
import 'package:news/feature/news/presentation/cubit/bookmark_status_cubit.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final NewsEntity news;

  const ArticleDetailsScreen({super.key, required this.news});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<BookmarkStatusCubit>().checkBookmark(widget.news.url!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (widget.news.urlToImage != null &&
                      widget.news.urlToImage!.isNotEmpty)
                  ? Image.network(
                      widget.news.urlToImage!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 200,
                          child: Center(child: Icon(Icons.broken_image)),
                        );
                      },
                    )
                  : const SizedBox(
                      height: 200,
                      child: Center(child: Icon(Icons.image)),
                    ),
              const SizedBox(height: 16),
              Text(
                widget.news.title ?? "",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.news.author ?? ""),
              Text(widget.news.publishedAt.toString()),
              const SizedBox(height: 16),
              Text(widget.news.description ?? ""),
              const SizedBox(height: 16),
              Text(widget.news.content ?? ""),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<BookmarkStatusCubit, bool>(
        builder: (context, isBookmarked) {
          return FloatingActionButton(
            onPressed: () {
              if (isBookmarked) {
                context.read<BookmarkStatusCubit>().removeBookmark(
                  widget.news.url!,
                );
              } else {
                context.read<BookmarkStatusCubit>().addBookmark(widget.news);
              }
            },
            child: Icon(
              Icons.bookmark,
              color: isBookmarked ? Colors.red : Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
