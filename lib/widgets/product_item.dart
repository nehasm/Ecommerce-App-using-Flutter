import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/products_screen.dart';
import '../screens/Product_detail.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';
class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context,listen: false);
    final cart = Provider.of<Cart>(context,listen: false,);
    final authData = Provider.of<Auth>(context,listen:false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child:Card(
              child:Column(children: <Widget>[
                Container(
                height: 200,
                child:GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProductDetail.routeName,arguments: product.id,);
                },
                child: FadeInImage(placeholder: AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(product.imageurl,),
                fit: BoxFit.fill
                ,)     
                ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10),
                child: Column(
                  children: [
                  Row(      
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Text(product.title , 
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18,color: Colors.black),
                  ),
                  Consumer<Product>(
                    builder:(ctx,product,chid)=>IconButton(icon: Icon(product.isfavourite? Icons.favorite: Icons.favorite_border,),
                  onPressed: () {
                    product.toggleFavouriteStatus(authData.token,authData.userId);
                  },
                  color: Colors.black,
                  ),
                  ),
                  IconButton(icon: Icon(Icons.shopping_cart), 
                  onPressed:() {
                    cart.addItem(product.id, product.price, product.title);
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Added item to cart:'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(label: 'UNDO',onPressed: () {
                      cart.removeSingleItem(product.id);
                    },),),);
                  },
                  color: Colors.black,
                  )
                  ],
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text("Price: \$${product.price}", 
                    textAlign:TextAlign.left,
                    style: TextStyle(fontSize: 14,color: Colors.black),),
                  )
                ],),
              )
              
              ],)
            ),  
    );
      
  }
}