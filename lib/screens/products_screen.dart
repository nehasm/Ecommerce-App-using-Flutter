import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
import '../providers/product.dart';
import '../widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('MyShop'),
      ),
      body:ProductsGrid(),
    );
  }
}
