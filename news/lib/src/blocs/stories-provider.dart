import 'package:flutter/material.dart';

import 'stories-bloc.dart';
export 'stories-bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({ Key key, Widget child }) 
    : bloc = StoriesBloc(),
      super(key: key, child: child);

  bool updateShouldNotify(_) {
    return true;
  }

  static StoriesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<StoriesProvider>()).bloc;
  }
}