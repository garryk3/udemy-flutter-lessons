import 'package:prompter_igv/prompter_igv.dart';

void main() {
  final Prompter prompter = Prompter();
  final options = <Option>[
      Option('Red', '#foo'),
      Option('Blue', '#00f')
  ];
  
  final String colorCode = prompter.askMultiple('Select color', options);
  final bool answer = prompter.askBinary('Do you like this lib?');

  print(colorCode);
  print(answer);
}