import 'package:flutter/material.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final NewsEntity news;

  const ArticleDetailsScreen({super.key, required this.news});

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
              (news.urlToImage != null && news.urlToImage!.isNotEmpty)
                  ? Image.network(
                      news.urlToImage!,
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
                news.title ?? "",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(news.author ?? ""),
              Text(news.publishedAt.toString()),
              const SizedBox(height: 16),
              Text(news.description ?? ""),
              const SizedBox(height: 16),
              Text(news.content ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
