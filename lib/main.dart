import 'package:flutter/material.dart';
import 'package:mysmilespot/screens/edit_product.dart';
import './widgets/user_product_item.dart';
import './screens/cart_screen.dart';
import 'package:provider/provider.dart';
import './screens/products_screen.dart';
import './screens/Product_detail.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_product.dart';
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
      ),
      ChangeNotifierProvider(
        create: (ctx)=>Orders(),
      ),
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
        OrderScreen.routeName:(ctx)=>OrderScreen(),
        UserProductsScreen.routeName:(ctx)=>UserProductsScreen(),
        EditProductScreen.routeName:(ctx)=>EditProductScreen(),
      }
    ),);
  }
}
