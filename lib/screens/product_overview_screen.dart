import 'package:Shop_App/provider/products.dart';

import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/product_grid.dart';

import 'package:flutter/material.dart';
import '../provider/cart.dart';
import '../widgets/badge.dart';
import './cart_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavoritesOnly = false;
  var _isinit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchandSetProducts(); it will not work
    // Provider.of<Products>(context, listen: false).fetchandSetProducts(); it will work
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchandSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isinit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchandSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final productContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedvalue) {
              setState(() {
                if (selectedvalue == FilterOptions.Favorites) {
                  _showFavoritesOnly = true;
                  // productContainer.showFavoritesOnly();
                } else {
                  _showFavoritesOnly = false;
                  // productContainer.showAll();
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : ProductGrid(_showFavoritesOnly),
    );
  }
}
