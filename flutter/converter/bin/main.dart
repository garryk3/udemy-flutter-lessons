import 'dart:io';
import 'package:prompter_sg/prompter_sg.dart';

void main() {
    final prompter = Prompter();

    final bool choice = prompter.askBinary("Are you here to convert an image?");

    if(!choice) {
      exit(0);
    }
    final format = prompter.askMultiple('Select format: ', buildFormatOptions());
    final path = prompter.askMultiple('Select an image to convert: ', buildFileOptions());
}

List<Option> buildFormatOptions() {
  return [
    Option('Convert to jpg', 'jpg'),
    Option('Convert to png', 'png')
  ];
}

List<Option> buildFileOptions() {
  return Directory.current
    .listSync()
    .where((entity) {
      return FileSystemEntity
        .isFileSync(entity.path) && entity.path.contains(new RegExp(r'\.(png|jpg|jpeg|JPG)'));
    })
    .map((entity) {
      final filename = entity.path.split(Platform.pathSeparator).last;
      return Option(filename, entity);
    })
    .toList();
}