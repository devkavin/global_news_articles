// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/article.dart';
// import 'api_key.dart';

// class NewsService {
//   final String apiKey = myApiKey;
//   // 2 api urls
//   final String apiUrl = 'https://newsapi.org/v2/top-headlines';

//   Future<List<Article>> fetchArticlesByCategory(String category) async {
//     final response = await http
//         .get(Uri.parse('$apiUrl?country=us&category=$category&apiKey=$apiKey'));
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       final List<dynamic> articleList = responseData['articles'];
//       return articleList.map((article) => Article.fromJson(article)).toList();
//     } else {
//       throw Exception('Failed to fetch articles');
//     }
//   }

//   Future<List<Article>> fetchArticlesByQuery(String query) async {
//     final response = await http
//         .get(Uri.parse('$apiUrl?q=$query&sortBy=publishedAt&apiKey=$apiKey'));
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       final List<dynamic> articleList = responseData['articles'];
//       return articleList.map((article) => Article.fromJson(article)).toList();
//     } else {
//       throw Exception('Failed to fetch articles');
//     }
//   }

//   Future<List<Article>> fetchAllArticles() async {
//     final response =
//         await http.get(Uri.parse('$apiUrl?country=us&apiKey=$apiKey'));
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       final List<dynamic> articleList = responseData['articles'];
//       return articleList.map((article) => Article.fromJson(article)).toList();
//     } else {
//       throw Exception('Failed to fetch articles');
//     }
//   }

// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import 'api_key.dart';
import 'package:intl/intl.dart';

class NewsService {
  final String apiKey = myApiKey;
  final String apiUrl = 'https://newsapi.org/v2/top-headlines';
  final String apiUrlEverything = 'https://newsapi.org/v2/everything';

  final String dateSince = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(const Duration(days: 30)));

  Future<List<Article>> fetchArticlesByCategory(String category) async {
    final response = await http
        .get(Uri.parse('$apiUrl?country=us&category=$category&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> articleList = responseData['articles'];
      return articleList.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to fetch articles');
    }
  }

  Future<List<Article>> fetchArticlesByQuery(
    String query, {
    String language = 'en',
    String channel = 'bbc-news,cnn,nbc-news',
  }) async {
    final StringBuffer queryUrl = StringBuffer(
        '$apiUrlEverything?q=$query&from=$dateSince&sortBy=relevancy');
    debugPrint(dateSince);

    if (language != null) {
      queryUrl.write('&language=$language');
    }

    if (channel != null) {
      queryUrl.write('&sources=$channel');
    }

    queryUrl.write('&apiKey=$apiKey');

    final response = await http.get(Uri.parse(queryUrl.toString()));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> articleList = responseData['articles'];
      return articleList.map((article) => Article.fromJson(article)).toList();
    } else {
      debugPrint(response.body.toString());
      throw Exception('Failed to fetch articles');
    }
  }

  Future<List<Article>> fetchBreakingNews(
      {String country = 'us',
      String language = 'en',
      String category = 'general'}) async {
    final StringBuffer queryUrl = StringBuffer('$apiUrl?sortBy=publishedAt');

    if (country != null) {
      queryUrl.write('&country=$country');
    }

    if (language != null) {
      queryUrl.write('&language=$language');
    }

    if (category != null) {
      queryUrl.write('&category=$category');
    }

    queryUrl.write('&apiKey=$apiKey');

    final response = await http.get(Uri.parse(queryUrl.toString()));

    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> articleList = responseData['articles'];
      return articleList.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to fetch articles${response.body}');
    }
  }

  Future<List<Article>> fetchAllArticles(
      {String country = 'us',
      String language = 'en',
      String channel = 'bbc'}) async {
    final StringBuffer queryUrl =
        StringBuffer('$apiUrlEverything?sortBy=publishedAt');

    if (country != null) {
      queryUrl.write('&country=$country');
    }

    if (language != null) {
      queryUrl.write('&language=$language');
    }

    if (channel != null) {
      queryUrl.write('&sources=$channel');
    }

    queryUrl.write('&apiKey=$apiKey');

    final response = await http.get(Uri.parse(queryUrl.toString()));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> articleList = responseData['articles'];
      return articleList.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to fetch articles');
    }
  }
}
