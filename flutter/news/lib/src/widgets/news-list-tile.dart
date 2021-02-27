import 'package:flutter/material.dart';
import 'dart:async';

import '../models/item-model.dart';
import '../blocs/stories-provider.dart';
import 'loading-container.dart';

class NewsListTile extends StatelessWidget {
  NewsListTile({ this.itemId }) {}

  final int itemId;

  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchItem(itemId);

    return StreamBuilder(
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if(!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if(!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return buildTile(context, itemSnapshot.data);
          }
        );
      }, 
      stream: bloc.items,
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(children: <Widget>[
      ListTile(
        onTap: () {
          Navigator.pushNamed(context, '/${item.id}');
        },
        title: Text(item.title),
        subtitle: Text('${item.score} votes'),
        trailing: Column(children: <Widget>[
          Icon(Icons.comment),
          Text('${item.descendants}')
        ],),
      ),
      Divider(
        height: 8.0,
      )
    ],);
  }
}