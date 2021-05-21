import 'dart:async';
import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reduxtodo/model/model.dart';
import 'actions.dart';


//saves state to saved preferences
void saveToPrefs(AppState state) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(state.toJson());
  await preferences.setString('itemsState', string); //binds this appstatejson to 'itemState' keyword
}


// loads data from sharedpreferences 
Future<AppState> loadFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? stateFromPref = preferences.getString('itemsState');
  if(stateFromPref!=null){
    Map state = json.decode(stateFromPref);
    return AppState.fromJson(state);
  }
  return AppState.initialState();
}

//wrapper function to load state from sharedpreferences by calling loadFromPrefs() for different actions by binding actions 
//to type to create "TypedMiddlewares" these are middlewares load because of an action.
Middleware<AppState> _loadFromPrefs(){
   return (Store<AppState> store, action, NextDispatcher next){
     next(action);
     loadFromPrefs()
        .then((state) => store.dispatch(LoadedItemsAction(state.items)));
   };
} 
//wrapper function to save state by calling saveToPrefs() for different actions by binding actions to type to create "TypedMiddlewares"
Middleware<AppState> _saveToPrefs(){
  return(Store<AppState> store, action, NextDispatcher next){
    next(action);

    saveToPrefs(store.state);
  };
} 

//combines middlewares into one big list of middlewares from two categories ie, loaditems, saveitems.
List<Middleware<AppState>> appStateMiddleWare(){
  final loadItems = _loadFromPrefs();
  final saveItems = _saveToPrefs();

  return [
    TypedMiddleware<AppState, AddItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemsAction>(saveItems),
    TypedMiddleware<AppState, ItemCompletedAction>(saveItems),
    TypedMiddleware<AppState, GetItemsAction>(loadItems),
  ];

}

// ignore: slash_for_doc_comments
/** old monolithic middleware **/
// void appStateMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) async {
//   next(action);
//   if(action is AddItemAction||
//      action is RemoveItemAction||
//      action is RemoveItemsAction){
//         saveToPrefs(store.state);
//       }
//   if(action is GetItemsAction){
//     await loadFromPrefs().then((value) => LoadedItemsAction(value.items))
//     .then((loadeditemsaction) => store.dispatch(loadeditemsaction));
//   }
 
// }
