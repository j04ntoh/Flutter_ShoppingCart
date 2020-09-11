import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: unused_import
import './screens/products_overview_screen.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/splash_screen.dart';

import './provider/auth.dart';
import './provider/products.dart';
import './provider/cart.dart';
import './provider/orders.dart';
import './helpers/custom_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          //new
          create: (_) => Products('', [], ''),
          update: (ctx, auth, prevProducts) => Products(auth.token,
              prevProducts == null ? [] : prevProducts.items, auth.userId),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders('', '', []),
          update: (ctx, auth, prevOrders) => Orders(auth.token, auth.userId,
              prevOrders == null ? [] : prevOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Timberland',
          theme: ThemeData(
              primarySwatch: Colors.orange,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                ),
              ),
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
                TargetPlatform.android: CustomPageTransitionBuilder(),
              })),
          home: auth.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
