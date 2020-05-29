import './option.dart';
import './terminal.dart';

class Prompter {
  final Terminal terminal = Terminal();
  static final _instance = Prompter._construct();

  factory Prompter() {
    return _instance;
  }

  Prompter._construct();

  void ask(String prompt, List<Option> options) {
    terminal.printPrompt(prompt);
    terminal.printOptions(options);
  }
}