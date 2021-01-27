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
        Padding(
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
            width: double.infinity,
            height:370,
            child:Container(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              shape: BoxShape.rectangle, 
              boxShadow: [BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
              ),
              ],
              ),
              child: Image.network(
                loadedProduct.imageurl,
                fit:BoxFit.fill,
              ),
            ),
      ),
          ),
        ),
      // SizedBox(height:10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal:20),
        child: Container(
          alignment: Alignment.topLeft,
          child: Text('Price: \$${loadedProduct.price}',style:TextStyle(color: Colors.black,fontSize: 20,
          ),
          textAlign:TextAlign.left,
          ),
        ),
      ),
      SizedBox(height:10,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal:20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:10),
        width: double.infinity,
        child:Text(loadedProduct.description,
        textAlign:TextAlign.left,
        softWrap: true,
        style: TextStyle(fontSize: 15),
        ),
        ),
      ),
      ],
    ),
    ),
    );
  }
}