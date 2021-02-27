import 'package:flutter/material.dart';

import '../../ui/screens/login.dart';
import '../../blocs/provider.dart';

class App extends StatelessWidget {
  build(context) {
    return Provider(
      child: MaterialApp(
        title:  'Log me',
        home: Scaffold(
          body: LoginScreen(),
        )
    ));
  }
}