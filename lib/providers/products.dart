import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import './product.dart';
import '../models/httpexception.dart';
import 'package:http/http.dart' as http;
class Products with ChangeNotifier {
  List<Product> _items = [
  //   Product(
  //     id: 'm1',
  //     title: 'shirt',
  //     description: 'Its a beautiful shirt',
  //     price: 34.89,
  //     imageurl: 'https://static.cilory.com/273124-thickbox_default/nologo-navy-casual-shirt.jpg',
  //   ),
  //   Product(
  //     id: 'm2',
  //     title: 'skirt',
  //     description: 'Model Skirt',
  //     price: 99.65,
  //     imageurl: 'https://static.cilory.com/468597-large_default/navy-floral-printed-georgette-long-skirt.jpg',
  //   ),
  //   Product(
  //     id: 'm3',
  //     title: 'tshirt',
  //     description: 'Wetern tshirt',
  //     price: 45.33,
  //     imageurl: 'https://static.cilory.com/423289-large_default/comfort-lady-red-short-sleeve-tee.jpg',
  //   ),
  //   Product(
  //     id:'m4',
  //     title: 'dress',
  //     description: 'Beautiful Indian dress',
  //     price: 65.89,
  //     imageurl: 'https://static.cilory.com/434303-large_default/black-brown-chanderi-cotton-un-stitched-suit.jpg',
  //   ),
  //   Product(
  //     id: 'm5',
  //     title: 'jacket',
  //     description: 'Colorful fancy scaff',
  //     price: 34.55,
  //     imageurl: 'https://static.cilory.com/418437-large_default/slingshot-navy-heavy-winter-jacket.jpg',
  //   ),
  //   Product(
  //     id: 'm6',
  //     title: 'jeans',
  //     description: 'Fashionale denim',
  //     price: 89.99,
  //     imageurl: 'https://static.cilory.com/295061-large_default/spykar-giselle-dark-blue-low-rise-jegging.jpg',
  //     ),
  //     Product(
  //       id: 'm7',
  //       title: 'shoes',
  //       description: 'Comfortable shoes',
  //       price: 78.43,
  //       imageurl: 'https://static.cilory.com/417953-large_default/estonished-blue-heeled-sneakers.jpg',
  //     ),
  ];
  // var _showFavouritesOnly = false;
  final String userId;
  final String authToken;
  Products(this.authToken,this.userId,this._items);
  List<Product> get items {
    // if (_showFavouritesOnly) {
    //   return _items.where((prodItem)=>prodItem.isfavourite).toList();
    // }
    return [..._items];
  }
  Product findById(String id) {
    return _items.firstWhere((prod)=>prod.id==id);
  }
  // void showFavouritesOnly () {
  //   _showFavouritesOnly = true;
  //   notifyListeners();
  // }
  // void showAll (){
  //   _showFavouritesOnly = false;
  //   notifyListeners();
  // }
  List<Product> get favouriteItems {
    return _items.where((prodItem)=>prodItem.isfavourite).toList();
  }
  Future<void> fetchProducts([bool filterByUser = false]) async{
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"': '';
    var url = 'https://flutter-ecommerce-app-b2e20-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString';
    // final url = 'https://flutter-ecommerce-app-b2e20-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractdata = json.decode(response.body) as Map<String,dynamic>;
      if (extractdata==null){
        return;
      }
      url = 'https://flutter-ecommerce-app-b2e20-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractdata.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id:prodId,
          title:prodData['title'],
          description:prodData['description'],
          price:prodData['price'],
          isfavourite:favoriteData==null?false:favoriteData[prodId]??false,
          imageurl:prodData['imageurl'],
        )
       );});
       _items=loadedProducts;
       notifyListeners();
    } catch(error) {
      throw (error);
    }
    
  }

  Future<void> addProduct(Product product) async {
    final url = 'https://flutter-ecommerce-app-b2e20-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try{
    final response = await http.post(url,
    body: json.encode({
      'title':product.title,
      'description':product.description,
      'imageurl':product.imageurl,
      'price':product.price,
      'creatorId': userId,
    })
    );
    final newProduct = Product(
      title: product.title,
      id: json.decode(response.body)['name'],
      imageurl: product.imageurl,
      description: product.description,
      price: product.price,
    );
    _items.add(newProduct);
    notifyListeners();
    } catch(error){
      print(error);
      throw error;
    }
      
  }
  Future<void> updateProduct (String id,Product newProduct) async{
    final prodIndex = _items.indexWhere((prod) => prod.id==id);
    if (prodIndex>0){
    final url = 'https://flutter-ecommerce-app-b2e20-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    await http.patch(url,
    body:json.encode({
      'title':newProduct.title,
      'description':newProduct.description,
      'price':newProduct.price,
      'imageurl':newProduct.imageurl,
    }));
    _items[prodIndex]=newProduct;
    notifyListeners();
    } else{
      print('...');
    }
  }
  Future<void> deleteProduct(String id) async{
    final url = 'https://flutter-ecommerce-app-b2e20-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id==id);
    var existingProduct = _items[existingProductIndex];    
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
      if(response.statusCode>=400){
        _items.insert(existingProductIndex,existingProduct);
      notifyListeners();
        throw HttpException('Could not delete product.');
      }
      existingProduct = null; 
  }
}