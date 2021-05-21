import 'package:flutter/foundation.dart';

class Item{
  final int id ;
  final String body;

  Item(this.id, this.body);

  Item copyWith({int? id, String? body}){
    return Item(
      id??this.id,
      body??this.body
    );
  }
  Item.fromJson(Map json) : body = json['body'], id = json['id'];

  Map toJson() => {
    'id': id,
    'body': body 
  };
}

class AppState{
  final List<Item> items;

  AppState(this.items);

  AppState.initialState(): items = List.unmodifiable(<Item>[]);

  AppState.fromJson(Map json)
    : items = (json['items'] as List).map((e) => Item.fromJson(e)).toList();

  Map toJson() => {'items': items};

}