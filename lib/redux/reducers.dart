import 'package:redux/redux.dart';
import 'package:reduxtodo/model/model.dart';
import 'actions.dart';

AppState appStateReducer(AppState state,dynamic action){

  return AppState(itemReducer(state.items, action));
}

//combines all reducers into one by taking iterable object of many reducer functions for modular reducers.
Reducer<List<Item>> itemReducer = combineReducers<List<Item>>([
  TypedReducer<List<Item>, AddItemAction>(addItemReducer),
  TypedReducer<List<Item>, RemoveItemAction>(removeItemReducer),
  TypedReducer<List<Item>, RemoveItemsAction>(removeItemsReducer),
  TypedReducer<List<Item>, LoadedItemsAction>(loadedItemsReducer),
  TypedReducer<List<Item>, ItemCompletedAction>(itemCompletedReducer)
]);

List<Item> addItemReducer(List<Item> items, AddItemAction action) {
  return []
    ..addAll(items)
    ..add(Item(id: action.id, body: action.item));
}

List<Item> removeItemReducer(List<Item> items, RemoveItemAction action) {
  return List.unmodifiable(List.from(items)..remove(action.item));
}

List<Item> removeItemsReducer(List<Item> items,RemoveItemsAction action) {
  return List.unmodifiable([]);
}
List<Item> loadedItemsReducer(List<Item> items, LoadedItemsAction action){
   return action.items;
}
List<Item> itemCompletedReducer(List<Item> items, ItemCompletedAction action){
  return items
      .map((item) => item.id == action.item.id? item.copyWith(completed: !item.completed): item) //toggle completed true or false when users clicks 
      .toList();
}

//===========old method where reducer was a monolith single function churing all incoming actions so we couldn't have static types for action=========//
// List<Item> itemReducer(List<Item> state, action){

//   if(action is AddItemAction){
//     return []
//     ..addAll(state)
//     ..add(Item(id: action.id,body: action.item));
//   }

//   if(action is RemoveItemAction){
//     return List.unmodifiable(List.from(state)..remove(action.item));
//   }

//   if(action is RemoveItemsAction){
//     return List.unmodifiable([]);
//   }

//   if(action is LoadedItemsAction){
//     return action.items;
//   }

//   return state;
// }