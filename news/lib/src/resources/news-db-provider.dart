import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item-model.dart';
import './repository.dart';

class NewsDbProvider implements Cache, Source {
  Database db;

  NewsDbProvider() {
    init();
  }

  Future<List<int>> fetchTopIds() async {
    return null;
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');
    

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, version) {
        newDb.execute("""
          CREATE TABLE items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """);
      }
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id]
    );

    if(maps.length > 0) {
      return ItemModel.fromDB(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert("Items", item.toMapForDb());
  }
}

final newsDbProvider = NewsDbProvider();