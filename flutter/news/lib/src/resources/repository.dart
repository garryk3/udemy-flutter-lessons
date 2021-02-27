import 'dart:async';

import '../models/item-model.dart';
import 'news-api-provider.dart';
import 'news-db-provider.dart';

class Repository {

  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider()
  ];
  List<Cache> caches = <Cache>[
    newsDbProvider

  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if(item != null) {
        break;
      }
    }

    for (Cache cache in caches) {
      if(cache != source) {
        cache.addItem(item);
      }
    }

    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }

}


abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}

abstract class  Source {
    Future<ItemModel> fetchItem(int id);
    Future<List<int>> fetchTopIds();
}