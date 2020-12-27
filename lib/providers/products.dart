import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import './product.dart';
class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'm1',
      title: 'shirt',
      description: 'Its a beautiful shirt',
      price: 34.89,
      imageurl: 'https://static.cilory.com/273124-thickbox_default/nologo-navy-casual-shirt.jpg',
    ),
    Product(
      id: 'm2',
      title: 'skirt',
      description: 'Model Skirt',
      price: 99.65,
      imageurl: 'https://static.cilory.com/468597-large_default/navy-floral-printed-georgette-long-skirt.jpg',
    ),
    Product(
      id: 'm3',
      title: 'tshirt',
      description: 'Wetern tshirt',
      price: 45.33,
      imageurl: 'https://static.cilory.com/423289-large_default/comfort-lady-red-short-sleeve-tee.jpg',
    ),
    Product(
      id:'m4',
      title: 'dress',
      description: 'Beautiful Indian dress',
      price: 65.89,
      imageurl: 'https://static.cilory.com/434303-large_default/black-brown-chanderi-cotton-un-stitched-suit.jpg',
    ),
    Product(
      id: 'm5',
      title: 'jacket',
      description: 'Colorful fancy scaff',
      price: 34.55,
      imageurl: 'https://static.cilory.com/418437-large_default/slingshot-navy-heavy-winter-jacket.jpg',
    ),
    Product(
      id: 'm6',
      title: 'jeans',
      description: 'Fashionale denim',
      price: 89.99,
      imageurl: 'https://static.cilory.com/295061-large_default/spykar-giselle-dark-blue-low-rise-jegging.jpg',
      ),
      Product(
        id: 'm7',
        title: 'shoes',
        description: 'Comfortable shoes',
        price: 78.43,
        imageurl: 'https://static.cilory.com/417953-large_default/estonished-blue-heeled-sneakers.jpg',
      ),
  ];
  List<Product> get items {
    return [..._items];
  }
  Product findById(String id) {
    return _items.firstWhere((prod)=>prod.id==id);
  }
  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}