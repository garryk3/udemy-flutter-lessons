import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'validators.dart';

class Bloc extends Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (emailVal, pasVal) {
    return true;
  });

  submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print('Email is $validEmail');
    print('Password is $validPassword');
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
