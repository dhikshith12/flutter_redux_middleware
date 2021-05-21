import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:reduxtodo/model/model.dart';
import 'package:reduxtodo/redux/actions.dart';


class ViewModel{
  final AppState store;
  final Function(String) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;

  ViewModel(this.store, this.onAddItem, this.onRemoveItem, this.onRemoveItems);
  
  factory ViewModel.create(Store<AppState> store){
    _onAddItem(String body){
      store.dispatch(AddItemAction(body));
    }
    _onRemoveItem(Item item){
      store.dispatch(RemoveItemAction(item));
    }
    _onRemoveItems(){
      store.dispatch(RemoveItemsAction());
    }
    return ViewModel(store.state,_onAddItem,_onRemoveItem,_onRemoveItems);
  }

}

class ItemListWidget extends StatelessWidget {
  final ViewModel model;
  ItemListWidget(this.model);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: model.store.items.map((Item e) => ListTile(
        title: Text(e.body),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => model.onRemoveItem(e),
        ),
      )).toList(),
    );
  }
}

class RemoveItemsButton extends StatelessWidget {
  final ViewModel model;
  RemoveItemsButton(this.model);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Delete all Items'),
      onPressed: ()=>model.onRemoveItems(),
    );
  }
}

class AddItemWidget extends StatelessWidget {
  final ViewModel model;
  AddItemWidget(this.model);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'add a Todo Item'
      ),
      onSubmitted: (String s) {
        model.onAddItem(s);
        controller.text = '';
      },
    );
  }
  
}

