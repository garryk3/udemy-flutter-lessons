import 'package:flutter/material.dart';
import 'screens/news-list.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      home: NewsList(),
      title: 'News'
    );
  }
}