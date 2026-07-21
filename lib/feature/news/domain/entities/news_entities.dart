import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  const NewsEntity({
    this.id,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  final String? author;
  final String? content;
  final String? description;
  final int? id;
  final DateTime? publishedAt;
  final String? title;
  final String? url;
  final String? urlToImage;

  @override
  List<Object?> get props {
    //props check below objects are eaual or not
    return [
      id,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }
}
