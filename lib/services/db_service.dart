// To be implemented in the future to save bookmarks locally

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DBService {
//   static const String _databaseName = 'bookmarks.db';
//   static const String _tableName = 'bookmarks';
//   static const int _databaseVersion = 1;

//   static Database? _database;

//   static Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     _database = await _initDatabase();
//     return _database!;
//   }

//   static Future<Database> _initDatabase() async {
//     final String databasePath = await getDatabasesPath();
//     final String path = join(databasePath, _databaseName);
//     return await openDatabase(path,
//         version: _databaseVersion, onCreate: _onCreate);
//   }

//   static Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $_tableName(
//         id INTEGER PRIMARY KEY,
//         title TEXT,
//         author TEXT,
//         description TEXT,
//         url TEXT,
//         urlToImage TEXT,
//         publishedAt TEXT
//       )
//     ''');
//   }

//   static Future<void> saveBookmark(Map<String, dynamic> article) async {
//     final Database db = await database;
//     await db.insert(_tableName, article,
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   static Future<List<Map<String, dynamic>>> getBookmarks() async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> results = await db.query(_tableName);
//     return results;
//   }

//   static Future<void> deleteBookmark(String title) async {
//     final Database db = await database;
//     await db.delete(_tableName, where: 'id = ?', whereArgs: [title]);
//   }

//   static Future<void> deleteAllBookmarks() async {
//     final Database db = await database;
//     await db.delete(_tableName);
//   }

//   static Future<bool> isArticleBookmarked(String url) async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> results =
//         await db.query(_tableName, where: 'url = ?', whereArgs: [url]);
//     return results.isNotEmpty;
//   }

//   static Future<void> updateBookmarks(Map<String, dynamic> article) async {
//     final Database db = await database;
//     await db.update(_tableName, article,
//         where: 'url = ?', whereArgs: [article['url']]);
//   }
// }
