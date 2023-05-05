import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:global_news_articles/screens/bookmarks_screen/bookmarks_screen.dart';
import '../../services/api_key.dart';
import '../../widgets/article_list_item.dart';
import '../article_details_screen/article_details_screen.dart';
import '../category_screen/category_screen.dart';
import '../search_screen/search_screen.dart';
import '../../models/article.dart';
import '../../services/news_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService _newsService = NewsService();
  List<Article> _articles = [];

  TextEditingController searchController = TextEditingController();

  get bookmarkedArticles => null;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    try {
      final List<Article> articles =
          await _newsService.fetchArticlesByCategory('general');
      setState(() {
        _articles = articles;
        debugPrint('Number of articles: ${_articles.length}');
      });
    } catch (e) {
      debugPrint('Error fetching articles: $e');
      if (myApiKey == 'Your Api Key') {
        // show a dialog to the user
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('API Key missing'),
            content: const Text(
                'Please add your API key from newsapi.org to lib/services/api_key.dart'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                // title should be in cereer
                decoration: BoxDecoration(
                  // get color fromtheme
                  color: Theme.of(context).primaryColor,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Select a category',
                    // center text
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('General News'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(
                          category: 'general',
                        )));
              },
            ),
            ListTile(
              title: const Text('Business'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(
                          category: 'business',
                        )));
              },
            ),
            ListTile(
              title: const Text('Technology'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(
                          category: 'technology',
                        )));
              },
            ),
            ListTile(
              title: const Text('Science'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(
                          category: 'science',
                        )));
              },
            ),
            ListTile(
              title: const Text('Health'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(
                          category: 'health',
                        )));
              },
            ),
            ListTile(
              title: const Text('Sports'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(
                          category: 'sports',
                        )));
              },
            ),
            ListTile(
              title: const Text('Entertainment'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryScreen(
                          category: 'entertainment',
                        )));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('News App'),
        // Search button
        actions: [
          IconButton(
              // open search page
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchScreen(searchController.text)));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchArticles,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Container(
                  child: _articles.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            CarouselSlider.builder(
                              itemCount: _articles.length,
                              itemBuilder: (context, index, realIndex) {
                                final Article article = _articles[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ArticleDetailScreen(
                                                article: article),
                                      ),
                                    );
                                  },
                                  child:
                                      NewsArticleCarouselItem(article: article),
                                );
                              },
                              options: CarouselOptions(
                                enableInfiniteScroll: true,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                enlargeCenterPage: true,
                                autoPlay: true,
                              ),
                            ),
                          ],
                        ),
                ),
                const Divider(),
                ListView.builder(
                  itemCount: _articles.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final Article article = _articles[index];
                    return Column(
                      children: [
                        NewsArticleListItem(article: article),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.bookmarks),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const BookmarksScreen()));
        },
      ),
    );
  }
}
