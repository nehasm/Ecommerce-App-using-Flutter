import 'package:flutter/material.dart';
import './screens/cart_screen.dart';
import 'package:provider/provider.dart';
import './screens/products_screen.dart';
import './screens/Product_detail.dart';
import './providers/products.dart';
import './providers/cart.dart';
void main() {
  runApp(MyApp(),);
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider (providers: [
      ChangeNotifierProvider(
    create :(ctx)=> Products(),
      ),
      ChangeNotifierProvider(
      create: (ctx)=> Cart(),
      )
    ],
    
    child:MaterialApp(
      title:'MySmileSpot',
      theme:ThemeData(
      primaryColor: Colors.red,
      accentColor: Colors.orange,
      fontFamily: 'Lato',
      ),
      home:ProductsScreen(),
      routes : {
        ProductDetail.routeName:(ctx)=> ProductDetail(),
        CartScreen.routeName:(ctx)=>CartScreen(),
      }
    ),);
  }
}
