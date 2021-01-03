import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
class ProductDetail extends StatelessWidget {
  // final String title;
  // ProductDetail(this.title);
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context,listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(title:Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
      child:Column(
        children:<Widget>[
        Container(
        width: double.infinity,
        height:300,
        child:Image.network(
          loadedProduct.imageurl,
          fit:BoxFit.cover,
        ),
      ),
      SizedBox(height:10),
      Text('\$${loadedProduct.price}',style:TextStyle(color: Colors.black,fontSize: 25,
      ),
      ),
      SizedBox(height:10,),
      Container(
        padding: EdgeInsets.symmetric(horizontal:10),
      width: double.infinity,
      child:Text(loadedProduct.description,
      textAlign:TextAlign.center,
      softWrap: true,
      ),),
      ],
    ),
    ),
    );
  }
}