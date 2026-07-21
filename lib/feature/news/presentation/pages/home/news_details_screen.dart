import 'package:flutter/material.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final NewsEntity news;

  const ArticleDetailsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.title!)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(news.urlToImage!),
            const SizedBox(height: 16),
            Text(
              news.title!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(news.author!),
            Text(news.publishedAt.toString()),
            const SizedBox(height: 16),
            Text(news.description!),
            const SizedBox(height: 16),
            Text(news.content!),
          ],
        ),
      ),
    );
  }
}
