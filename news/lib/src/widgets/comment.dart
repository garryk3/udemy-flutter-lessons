import 'package:flutter/material.dart';
import 'dart:async';

import 'loading-container.dart';
import '../models/item-model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({ this.itemId, this.itemMap, this.depth });

  Widget build(context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if(!snapshot.hasData) {
          return LoadingContainer();
        }
        final children = <Widget>[
          ListTile(
            title: buildText(snapshot.data.text),
            subtitle: snapshot.data.by == '' ? Text('Deleted') : Text(snapshot.data.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: 16.0 * (depth + 1)
            ),
          ),
          Divider()
        ];
        snapshot.data.kids.forEach((commentId) {
          children.add(Comment(itemId: commentId, itemMap: itemMap, depth: depth + 1,));
        });

        return Column(
          children: children
        );
      }
    );
  }

  Widget buildText(String text) {
    // manual parsing html Tags add here
    return Text(text);
  }
}