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
  
}

class AppState{
  final List<Item> items;

  AppState(this.items);

  AppState.initialState(): items = List.unmodifiable(<Item>[]);

}