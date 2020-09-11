import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';
import '../provider/auth.dart';
import '../helpers/custom_route.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Menu'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text(
              'Shop',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              'Orders',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);

              // Navigator.of(context).pushReplacement( CustomRoute(builder: (ctx) => OrdersScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Manage Products',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Log out',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              // clear deep nav when log out

              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
