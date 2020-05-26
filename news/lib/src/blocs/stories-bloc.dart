import 'package:rxdart/rxdart.dart';

import '../models/item-model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>();

  Stream<List<int>> get topIds => _topIds.stream;

  dispose() {
    _topIds.close();
  }
}