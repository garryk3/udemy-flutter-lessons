import 'dart:io';

import './option.dart';

class Terminal {
  void printPrompt(String prompt) {
    stdout.writeln(prompt);
  }

  String collectInput() {
    return stdin.readLineSync();
  }

  void printOptions(List<Option> options) {
    for(int i = 0; i < options.length; i++) {
      stdout.writeln('[${i}] - ${options[i].label}');
    }

    stdout.writeln('Enter the number of choice\n');
    stdout.write('>');
  }

  void clearScreen() {
    if(Platform.isWindows) {
      stdout.write('\x1B[2J\x1B[0f');
    } else {
      stdout.write('\x1B[2J\x1B[3J\x1B[H');
    }
  }
}