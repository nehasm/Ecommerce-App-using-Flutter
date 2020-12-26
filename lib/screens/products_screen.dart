import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  final List<Product> loadedProducts = [
    Product(
      id: 'm1',
      title: 'shirt',
      description: 'Its a beautiful shirt',
      price: 34.89,
      imageurl: 'https://static.cilory.com/273124-thickbox_default/nologo-navy-casual-shirt.jpg',
    ),
    Product(
      id: 'm2',
      title: 'skirt',
      description: 'Model Skirt',
      price: 99.65,
      imageurl: 'https://static.cilory.com/468597-large_default/navy-floral-printed-georgette-long-skirt.jpg',
    ),
    Product(
      id: 'm3',
      title: 'tshirt',
      description: 'Wetern tshirt',
      price: 45.33,
      imageurl: 'https://static.cilory.com/423289-large_default/comfort-lady-red-short-sleeve-tee.jpg',
    ),
    Product(
      id:'m4',
      title: 'dress',
      description: 'Beautiful Indian dress',
      price: 65.89,
      imageurl: 'https://static.cilory.com/434303-large_default/black-brown-chanderi-cotton-un-stitched-suit.jpg',
    ),
    Product(
      id: 'm5',
      title: 'jacket',
      description: 'Colorful fancy scaff',
      price: 34.55,
      imageurl: 'https://static.cilory.com/418437-large_default/slingshot-navy-heavy-winter-jacket.jpg',
    ),
    Product(
      id: 'm6',
      title: 'jeans',
      description: 'Fashionale denim',
      price: 89.99,
      imageurl: 'https://static.cilory.com/295061-large_default/spykar-giselle-dark-blue-low-rise-jegging.jpg',
      ),
      Product(
        id: 'm7',
        title: 'shoes',
        description: 'Comfortable shoes',
        price: 78.43,
        imageurl: 'https://static.cilory.com/417953-large_default/estonished-blue-heeled-sneakers.jpg',
      ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('MyShop'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        itemBuilder: (ctx,i)=>ProductItem(loadedProducts[i].id,loadedProducts[i].title,loadedProducts[i].imageurl,),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3/2,crossAxisSpacing: 10,mainAxisSpacing: 10,),
      ),
    );
  }
}