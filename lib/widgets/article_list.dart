import 'package:flutter/material.dart';
import '../models/article.dart';
import 'article_list_item.dart';

class ArticleList extends StatelessWidget {
  final List<Article> articles;

  const ArticleList({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) {
        return NewsArticleListItem(
          article: articles[index],
        );
      },
    );
  }
}
