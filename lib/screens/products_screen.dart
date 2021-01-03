import '../widgets/app_drawer.dart';

import '../providers/products.dart';
import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
// import '../providers/product.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
 enum FilterOptions {
    Favourite,
    All,
  }

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState()=> _ProductsScreenState();
}
class _ProductsScreenState extends State<ProductsScreen> {
  var _showOnlyFavourites = false;
  var _isInit = true;
  var _isloading = false;
  @override
  void initState() {
    // Provider.of<Products>(context).fetchProducts();
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchProducts();
    // });
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if (_isInit){
      setState(() {
        _isloading = true;
      });
      Provider.of<Products>(context).fetchProducts().then((_) {
        _isloading= false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final productContainer = Provider.of<Products>(context,listen: false,);
    return Scaffold(
      appBar: AppBar(
      title: Text('MyShop'),
      actions: <Widget>[
        PopupMenuButton(
        onSelected : (FilterOptions selectedValue){
          setState(() {
            if (selectedValue == FilterOptions.Favourite){
            // productContainer.showFavouritesOnly();
            _showOnlyFavourites = true;
          }else {
            _showOnlyFavourites = false;
            // productContainer.showAll();
          }
          });
          
        },
        icon:Icon(
          Icons.more_vert,
        ),
        itemBuilder : (_) =>[
          PopupMenuItem(child: Text('Only Favourites'),value:FilterOptions.Favourite),
          PopupMenuItem(child: Text('Show All'),value:FilterOptions.All),
        ],
      ),
      Consumer<Cart>(builder: (_,cart,ch)=>Badge(child:ch, value: cart.itemCount.toString(),
      ),
      child: IconButton(
        icon: Icon(Icons.shopping_cart,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(CartScreen.routeName);
        },
      ),
      ), 
      ]
      ),
      drawer: AppDrawer(),
      body:_isloading?Center(child:CircularProgressIndicator(),) :ProductsGrid(_showOnlyFavourites),
    );
  }
}
