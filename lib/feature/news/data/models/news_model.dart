// we need model cause domain layer should be sperated and if we later change json to xml
import 'package:news/feature/news/domain/entities/news_entities.dart';

class NewsModel extends NewsEntity {
  const NewsModel({
    super.id,
    super.author,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      author: json["author"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: json["publishedAt"] != null
          ? DateTime.parse(json["publishedAt"])
          : null,
      content: json["content"],
    );
  }
}
