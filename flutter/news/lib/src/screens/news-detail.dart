import 'package:flutter/material.dart';
import 'dart:async';

import '../blocs/comments-provider.dart';
import '../models/item-model.dart';
import '../widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail({ this.itemId });

  Widget build(context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('header detail'),
      ),
      body: buildBody(bloc)
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if(!snapshot.hasData) {
          return Text('loading');
        }
        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if(!itemSnapshot.hasData) {
              return Text('loading');
            }
            return buildList(itemSnapshot.data, snapshot.data);
          },
          future: itemFuture
        );
      },
    );
  } 

  Widget buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        )
      )
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[
        buildTitle(item)
    ];
    final commentsList = item.kids.map((commentId) {
      return Comment(itemId: commentId, itemMap: itemMap, depth: 0,);
    }).toList();

    children.addAll(commentsList);
    return ListView(
      children: children,
    );
  }
}