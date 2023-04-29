import 'package:flutter/material.dart';

class Article {
  final String title;
  final String author;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String sourceName;

  Article({
    required this.title,
    required this.author,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.sourceName,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? "",
      author: json['author'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
      content: json['content'] ?? "",
      sourceName: json['source']['name'] ?? "",
    );
  }

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'sourceName': sourceName,
    };
  }

  // fromMap
  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'] ?? "",
      author: '',
      content: '',
      description: '',
      publishedAt: '',
      sourceName: '',
      url: '',
      urlToImage: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'sourceName': sourceName,
    };
  }
}

class ArticleShortCard extends StatelessWidget {
  final Article article;

  const ArticleShortCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = article.title.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
    final description =
        article.description.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class ArticleDescCard extends StatelessWidget {
  final Article article;

  const ArticleDescCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = article.title.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
    final description =
        article.description.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          article.author ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Text(
          description ?? '',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          article.content ?? '',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'Source: ${article.sourceName}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Published At: ${article.publishedAt}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
