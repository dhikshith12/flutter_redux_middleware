import 'package:flutter/material.dart';
import 'package:reduxtodo/redux/actions.dart';
import 'package:reduxtodo/redux/middleware.dart';
import 'redux/reducers.dart';
import 'components/homeWidgets.dart';
import 'model/model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final DevToolsStore<AppState> stateStore = DevToolsStore<AppState>(
      appStateReducer,
      initialState: AppState.initialState(),
      middleware: [appStateMiddleware]
    );
    return StoreProvider<AppState>(
        store: stateStore,
        child: MaterialApp(
        title: 'Redux Items',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StoreBuilder<AppState>(
          onInit: (store) => store.dispatch(GetItemsAction()),
          builder: (BuildContext context, Store<AppState> store) => MyHomePage(stateStore),
          ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  DevToolsStore store;
  MyHomePage(this.store);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redux Todo List'),
      ),
      body: StoreConnector<AppState,ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) => Column(
          children: <Widget>[
            AddItemWidget(viewModel),
            Expanded(child: ItemListWidget(viewModel)),
            RemoveItemsButton(viewModel),
          ],
        ),
        ),
        drawer: Container(
          color: Colors.white,
          child: ReduxDevTools(store),
        ),
    );
  }
}
