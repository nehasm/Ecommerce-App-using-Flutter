import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class CartItem{
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem ({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map <String, CartItem> _items = {};
  Map <String , CartItem> get items {
    return {..._items};
  }
  int get itemCount {
    return _items.length;
  }
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key,cartItem) {
    total += cartItem.price*cartItem.quantity;
    });
    return total;
  }
  void addItem (String productId, double price,String title) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (existingcartitem) => CartItem(
        id:existingcartitem.id,
        title:existingcartitem.title,
        quantity :existingcartitem.quantity+1,
        price:existingcartitem.price,),);
    }else{
      _items.putIfAbsent(productId, () => CartItem(
        id: DateTime.now().toString(),
        title:title, 
        quantity:1, 
        price:price),);
    }
    notifyListeners();
  }

}