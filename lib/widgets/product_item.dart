import 'package:flutter/material.dart';

import '../screens/products_screen.dart';
import '../screens/Product_detail.dart';


class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageurl;

  ProductItem(this.id,
    this.title,
    this.imageurl,
  );
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child:GridTile(
      child:GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> ProductDetail(title),),);
      },
      child: Image.network(
      imageurl,
      fit: BoxFit.cover,
      ),),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading: IconButton(icon: Icon(Icons.favorite),
        onPressed: () {},
        color: Theme.of(context).accentColor,
        ),
        title:Text(title , 
        textAlign: TextAlign.center),
        trailing: IconButton(icon: Icon(Icons.shopping_cart), 
        onPressed:() {},
        color: Theme.of(context).accentColor,
        ),
        ),
      ),
      );
  }
}