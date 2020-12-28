import 'package:flutter/material.dart';
import '../providers/products.dart';
import '../providers/product.dart';
import './product_item.dart';
import 'package:provider/provider.dart';
class ProductsGrid extends StatelessWidget {
  final bool showfavourites;
  ProductsGrid(this.showfavourites);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showfavourites ? productsData.favouriteItems: productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (ctx,i) => ChangeNotifierProvider.value(
          value:products[i],
          child:ProductItem(),),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3/2,crossAxisSpacing: 10,mainAxisSpacing: 10,),
      );
  }
}