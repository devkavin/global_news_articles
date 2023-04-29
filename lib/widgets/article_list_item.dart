// import 'package:flutter/material.dart';
// import '../models/article.dart';
// import '../screens/article_details_screen/article_details_screen.dart';

// class ArticleListItem extends StatelessWidget {
//   final Article article;

//   const ArticleListItem({Key? key, required this.article}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ArticleDetailScreen(article: article),
//           ),
//         );
//       },
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             AspectRatio(
//               aspectRatio: 16 / 9,
//               child: Image.network(
//                 article.urlToImage ?? '',
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     article.title,
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     article.description ?? '',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     article.sourceName,
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../models/article.dart';
import '../screens/article_details_screen/article_details_screen.dart';

class NewsArticleListItem extends StatelessWidget {
  final Article article;
  final VoidCallback? onPressed;

  const NewsArticleListItem({
    super.key,
    required this.article,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // shadow
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
          title: Text(
            article.title.length > 150
                ? '${article.title.substring(0, 150)}...'
                : article.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
          subtitle: Text(article.author),
          leading: SizedBox(
            width: 80,
            child: FadeInImage(
              // image: const AssetImage('assets/images/placeholder.png'),
              image: NetworkImage(article.urlToImage),
              fit: BoxFit.cover,
              // fit the entire height
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              placeholder: const AssetImage('assets/images/placeholder.png'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey,
                  child: const Center(
                    child: Icon(Icons.error),
                  ),
                );
              },
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ArticleDetailScreen(
                  article: article,
                ),
              ),
            );
          },
          trailing: IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          )),
    );
  }
}

class NewsArticleCarouselItem extends StatelessWidget {
  final Article article;

  const NewsArticleCarouselItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    // Image is displayed without an error
                    child: FadeInImage(
                      image: NetworkImage(article.urlToImage),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      placeholder:
                          const AssetImage('assets/images/placeholder.png'),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey,
                          child: const Center(
                            child: Icon(Icons.error),
                          ),
                        );
                      },
                    )),
              ),
              const SizedBox(height: 10),
              ArticleShortCard(article: article)
            ],
          ),
        ),
      ),
    );
  }
}

class BookmarkedArticleListItem extends StatelessWidget {
  final Article article;
  final VoidCallback? onPressed;

  const BookmarkedArticleListItem({
    super.key,
    required this.article,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // shadow
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
          title: Text(
            article.title.length > 150
                ? '${article.title.substring(0, 150)}...'
                : article.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
          subtitle: Text(article.author),
          leading: SizedBox(
            width: 80,
            child: FadeInImage(
              // image: const AssetImage('assets/images/placeholder.png'),
              image: NetworkImage(article.urlToImage),
              fit: BoxFit.cover,
              // fit the entire height
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              placeholder: const AssetImage('assets/images/placeholder.png'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey,
                  child: const Center(
                    child: Icon(Icons.error),
                  ),
                );
              },
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ArticleDetailScreen(
                  article: article,
                ),
              ),
            );
          },
          trailing: IconButton(
            icon: const Icon(Icons.bookmark),
            // onPressed to add to bookmark
            onPressed: () async {
              await (article);
            },
          )),
    );
  }
}
