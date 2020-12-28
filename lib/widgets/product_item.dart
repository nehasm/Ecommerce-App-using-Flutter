import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/products_screen.dart';
import '../screens/Product_detail.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context,listen: false,);
    final cart = Provider.of<Cart>(context,listen: false,);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child:GridTile(
      child:GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetail.routeName,arguments: product.id,);
      },
      child: Image.network(
      product.imageurl,
      fit: BoxFit.cover,
      ),),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading: Consumer<Product>(
          builder:(ctx,product,chid)=>IconButton(icon: Icon(product.isfavourite? Icons.favorite: Icons.favorite_border,),
        onPressed: () {
          product.toggleFavouriteStatus();
        },
        color: Theme.of(context).accentColor,
        ),),
        title:Text(product.title , 
        textAlign: TextAlign.center),
        trailing: IconButton(icon: Icon(Icons.shopping_cart), 
        onPressed:() {
          cart.addItem(product.id, product.price, product.title);
        },
        color: Theme.of(context).accentColor,
        ),
        ),
      ),
      );
  }
}