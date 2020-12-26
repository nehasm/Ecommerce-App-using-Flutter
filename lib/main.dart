import 'package:flutter/material.dart';
import './screens/products_screen.dart';
void main() {
  runApp(MyApp(),);
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'MySmileSpot',
      theme:ThemeData(
      primaryColor: Colors.red,
      accentColor: Colors.orange,
      fontFamily: 'Lato',
      ),
      home:ProductsScreen(),
    );
  }
}
