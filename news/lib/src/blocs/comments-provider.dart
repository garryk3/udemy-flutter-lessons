import 'package:flutter/material.dart';

import 'comments-bloc.dart';
export 'comments-bloc.dart';

class CommentsProvider extends InheritedWidget {
  final CommentsBloc bloc;

  CommentsProvider({ Key key, Widget child })
    : bloc = CommentsBloc(),
      super(key: key, child: child);

  bool updateShouldNotify(InheritedWidget oldWidget) {
    throw true;
  }

  static CommentsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CommentsProvider>()).bloc;
  }
}