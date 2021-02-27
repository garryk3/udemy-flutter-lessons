import 'package:flutter/material.dart';

import 'screens/news-detail.dart';
import 'screens/news-list.dart';
import 'blocs/stories-provider.dart';
import 'blocs/comments-provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          onGenerateRoute: getRoute
        ),
      ),
    );
  }
  
  Route getRoute(RouteSettings settings) {
    if(settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();
          
          return NewsList();
        }
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          int itemId = int.parse(settings.name.replaceFirst('/', ''));

          commentsBloc.fetchItemWithComments(itemId);
          return NewsDetail(itemId: itemId);
        }
      );
    }
  }
}