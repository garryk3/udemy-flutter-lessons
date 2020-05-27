import 'package:flutter/material.dart';
import 'screens/news-list.dart';
import 'blocs/stories-provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return StoriesProvider(
      child: MaterialApp(
        home: NewsList(),
        title: 'News'
      ),
    );
  }
}