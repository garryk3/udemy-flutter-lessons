import 'package:news/src/resources/news-api-provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('test fetch top ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3]), 200);
    });
    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3]);
  });

  test('test fetch item', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {
        'id': 1212
      };
      return Response(json.encode(jsonMap), 200);
    });
    final item = await newsApi.fetchItem(1212);

    expect(item.id, 1212);
  });
}