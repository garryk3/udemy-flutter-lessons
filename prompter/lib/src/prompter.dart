import './option.dart';
import './terminal.dart';

class Prompter {
  final Terminal _terminal = Terminal();
  static final _instance = Prompter._construct();

  factory Prompter() {
    return _instance;
  }

  Prompter._construct();

  String _ask(String prompt, List<Option> options) {
    _terminal.clearScreen();
    _terminal.printPrompt(prompt);
    _terminal.printOptions(options); 

    return _terminal.collectInput();
  }

  bool askBinary(String prompt) {
    final input = _ask('$prompt y/n', []);
    return input.contains('y');
  }

  dynamic askMultiple(String prompt, List<Option> options) {
    final input = _ask(prompt, options);
  
    try {
      return options[int.parse(input)].value;
    } catch(error) {
      print(error);
      askMultiple(prompt, options);
    }
  }
}