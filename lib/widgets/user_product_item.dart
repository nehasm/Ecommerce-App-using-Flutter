import 'package:flutter/material.dart';
import '../screens/edit_product.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageurl;
  // final Function deletehandler;
  UserProductItem(this.id,this.title,this.imageurl,);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage:NetworkImage(imageurl),
        ),
        trailing: Container(
          width: 100,
          child:Row(children:<Widget>[
          IconButton(icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).pushNamed(EditProductScreen.routeName,
            arguments: id);
          },
          color: Theme.of(context).accentColor,),
          IconButton(icon: Icon(Icons.delete),
          onPressed: () async{
            try {
              await Provider.of<Products>(context,listen: false).deleteProduct(id);
            } catch(error){
              scaffold.showSnackBar(SnackBar(content: Text('Deleting Failed!',textAlign: TextAlign.center,),));
            }
            
          },
          color: Theme.of(context).accentColor,),
        ],
        ),
    ),
    );
  }
}