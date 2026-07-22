// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:news/feature/news/domain/entities/news_entities.dart';
part 'bookmark_model.g.dart';

@HiveType(typeId: 0)
class BookmarkModel extends HiveObject {
  @HiveField(0)
  final String url;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final DateTime publishedAt;
  @HiveField(5)
  final String title;
  @HiveField(6)
  final String urlToImage;

  BookmarkModel({
    required this.url,
    required this.author,
    required this.content,
    required this.description,
    required this.publishedAt,
    required this.title,
    required this.urlToImage,
  });

  factory BookmarkModel.fromEntity(NewsEntity entity) {
    return BookmarkModel(
      author: entity.author ?? '',
      content: entity.content ?? '',
      description: entity.description ?? '',
      publishedAt: entity.publishedAt ?? DateTime.now(),
      title: entity.title ?? '',
      url: entity.url ?? '',
      urlToImage: entity.urlToImage ?? '',
    );
  }

  NewsEntity toEntity() {
    return NewsEntity(
      author: author,
      content: content,
      description: description,
      publishedAt: publishedAt,
      title: title,
      url: url,
      urlToImage: urlToImage,
    );
  }
}
