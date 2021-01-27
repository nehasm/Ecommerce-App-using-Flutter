import 'package:flutter/material.dart';
import 'package:mysmilespot/providers/product.dart';
import './screens/splash_screen.dart';
import './screens/edit_product.dart';
import './widgets/user_product_item.dart';
import './screens/cart_screen.dart';
import 'package:provider/provider.dart';
import './screens/products_screen.dart';
import './screens/Product_detail.dart';
import './providers/products.dart';
import './screens/auth_screen.dart';
import './providers/cart.dart';
import './providers/auth.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_product.dart';
import './screens/auth_screen.dart';
void main() {
  runApp(MyApp(),);
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider (providers: [
      ChangeNotifierProvider(
        create:(ctx)=>Auth()
        ,),
      ChangeNotifierProxyProvider<Auth,Products>(
        update :(ctx,auth,previousProd)=> 
        Products(auth.token,auth.userId, previousProd==null
        ?[]
        :previousProd.items),
      ),
      ChangeNotifierProvider(
      create: (ctx)=> Cart(),
      ),
      ChangeNotifierProxyProvider<Auth,Orders>(
        update: (ctx,auth,previousOrders)=>Orders(auth.token,auth.userId, previousOrders==null?[]:previousOrders.orders),
      ),
    ],
    
    child:Consumer<Auth>(builder: (ctx,auth,_)=> MaterialApp(
      title:'MySmileSpot',
      theme:ThemeData(
      primaryColor: Colors.grey[700],
      accentColor: Colors.orange,
      fontFamily: 'Lato',
      ),
      home:auth.isAuth
      ? ProductsScreen()
      : FutureBuilder(
        future: auth.tryAutologin(),
        builder: (ctx,authResultSnapshot)=>authResultSnapshot.connectionState == ConnectionState.waiting? SplashScreen(): AuthScreen(),) ,
      // home: ProductDetail(),
      routes : {
        ProductDetail.routeName:(ctx)=> ProductDetail(),
        CartScreen.routeName:(ctx)=>CartScreen(),
        OrderScreen.routeName:(ctx)=>OrderScreen(),
        UserProductsScreen.routeName:(ctx)=>UserProductsScreen(),
        EditProductScreen.routeName:(ctx)=>EditProductScreen(),
      }
    ),
    ),
    ); 
  }
}
