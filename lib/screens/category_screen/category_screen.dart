import 'package:flutter/material.dart';
import '../../widgets/article_list_item.dart';
import '/models/article.dart';
import '/services/news_service.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  // _CategoryScreenState createState() => _CategoryScreenState();
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    _getArticles();
  }

  void _getArticles() async {
    NewsService newsService = NewsService();
    // List<Article> articles =
    //     await newsService.fetchArticlesByCategory(widget.category);
    // if the title.widget.category == 'general' then fetchBreakingNews else fetchArticlesByCategory
    List<Article> articles = widget.category == 'general'
        ? await newsService.fetchBreakingNews()
        : await newsService.fetchArticlesByCategory(widget.category);
    setState(() {
      _articles = articles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.category == 'general'
            ? const Text('General')
            : // title first letter to uppercase
            Text(widget.category[0].toUpperCase() +
                widget.category.substring(1)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _articles.length,
        itemBuilder: (context, index) {
          return NewsArticleListItem(article: _articles[index]);
        },
      ),
    );
  }
}
