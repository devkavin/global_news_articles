import 'package:flutter/material.dart';
import 'package:global_news_articles/widgets/article_list_item.dart';
import 'package:intl/intl.dart';
import '/services/db_service.dart';
import '/models/article.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        centerTitle: true,
        elevation: 0,
      ),
      body: const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Bookmarks Screen, coming soon!',
            ),
          ),
        ),
      ),
    );
  }
}
