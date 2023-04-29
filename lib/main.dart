import 'package:flutter/material.dart';
import '../screens/home_screen/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        // background of the scaffold is red
        scaffoldBackgroundColor: Colors.black,
      ),
      title: 'Material App',
      home: const SafeArea(child: HomeScreen()),
    );
  }
}
