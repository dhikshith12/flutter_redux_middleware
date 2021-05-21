import 'package:reduxtodo/model/model.dart';
import 'actions.dart';

AppState appStateReducer(AppState state,dynamic action){

  return AppState(itemReducer(state.items, action));
}

List<Item> itemReducer(List<Item> state, action){

  if(action is AddItemAction){
    return []
    ..addAll(state)
    ..add(Item(action.id,action.item));
  }

  if(action is RemoveItemAction){
    return List.unmodifiable(List.from(state)..remove(action.item));
  }

  if(action is RemoveItemsAction){
    return List.unmodifiable([]);
  }

  return state;

}