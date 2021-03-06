import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageurl;
  bool isfavourite;

  Product ({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageurl,
    this.isfavourite = false,
  });
  void _setFavValue(bool newValue){
    isfavourite = newValue;
    notifyListeners();
  }
  Future<void> toggleFavouriteStatus(String token,String userId)async {
    final oldStatus = isfavourite;
    isfavourite = !isfavourite;
    notifyListeners();
    final url = 'https://flutter-ecommerce-app-b2e20-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token'; 
    try{
      final response= await http.put(url,
      body:json.encode(
      isfavourite,
    ));
    if(response.statusCode>=400){
      _setFavValue(oldStatus);
    }
  }catch(error){
    _setFavValue(oldStatus);
  }
  }
}
