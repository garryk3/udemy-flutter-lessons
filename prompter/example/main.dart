import 'package:prompter_igv/src/terminal.dart';
import 'package:prompter_igv/src/option.dart';
import 'package:prompter_igv/src/prompter.dart';

void main() {
  final Prompter prompter = Prompter();
  final options = <Option>[
      Option('Red', '#foo'),
      Option('Blue', '#00f')
  ];
  
  prompter.ask('prompt', options);
}