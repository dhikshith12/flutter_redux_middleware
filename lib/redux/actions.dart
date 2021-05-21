import 'package:reduxtodo/model/model.dart';


class AddItemAction{
  static int _id = 0; //static _id is same variable across all instances of class AddItemAction so it is like auto increment.
  final String item;

  AddItemAction(this.item){
    _id++;
  }
  int get id => _id;
}

class RemoveItemAction{
  final Item item;
  RemoveItemAction(this.item);

}

class RemoveItemsAction{} //just to envoce a function 

class GetItemsAction{} // these two classes are 
//as pointless as mass effect 
//3's multiple endings useful for nothing except for revoking 
//a function idk how much a class takes memory in dart :(

class LoadedItemsAction{
  List<Item> items;
  LoadedItemsAction(this.items);
}

class ItemCompletedAction{
  final Item item;

  ItemCompletedAction(this.item);

}