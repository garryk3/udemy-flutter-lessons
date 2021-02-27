import 'package:flutter/material.dart';

import '../../blocs/block.dart';
import '../../blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  Widget build(context) {
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(children: <Widget>[
        emailField(bloc),
        passwordFiled(bloc),
        Container(margin: EdgeInsets.only(top: 20.0)),
        submitButton(bloc)
      ])
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'you@example.com',
            labelText: 'email address',
            errorText: snapshot.error
          ),
        );
      });
  }

  Widget passwordFiled(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText:  true,
          decoration: InputDecoration(
            hintText: 'password',
            labelText: 'password',
            errorText: snapshot.error          
          ),
        );
      }
    );
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Login'),
          color: Colors.blue,
          onPressed: !snapshot.hasData ? null : bloc.submit
        );
      }
    );
  }
}