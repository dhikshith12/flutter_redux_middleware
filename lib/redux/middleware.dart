import 'dart:async';
import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reduxtodo/model/model.dart';
import 'actions.dart';


void saveToPrefs(AppState state) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(state.toJson());
  await preferences.setString('itemsState', string);
}

Future<AppState> loadFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? stateFromPref = preferences.getString('itemsState');
  if(stateFromPref!=null){
    Map state = json.decode(stateFromPref);
    return AppState.fromJson(state);
  }
  return AppState.initialState();
}

void appStateMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) async {
  next(action);
  if(action is AddItemAction||
     action is RemoveItemAction||
     action is RemoveItemsAction){
        saveToPrefs(store.state);
      }
  if(action is GetItemsAction){
    await loadFromPrefs().then((value) => LoadedItemsAction(value.items))
    .then((loadeditemsaction) => store.dispatch(loadeditemsaction));
  }
 
}
