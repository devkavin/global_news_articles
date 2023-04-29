import 'package:flutter/material.dart';
import '../../services/news_service.dart';
import '../../models/article.dart';
import '../../widgets/article_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(String text, {super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final NewsService _newsService = NewsService();
  List<Article> _articles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[200],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                hintText: 'Search articles...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchArticles,
                ),
              ),
            ),
          ),
          Expanded(
            child: ArticleList(
              articles: _articles,
            ),
          ),
        ],
      ),
    );
  }

  void _searchArticles() async {
    String query = _searchController.text.trim();
    if (query.isNotEmpty) {
      List<Article> articles = await _newsService.fetchArticlesByQuery(query);
      setState(() {
        _articles = articles;
      });
    }
  }
}
