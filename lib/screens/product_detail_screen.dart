import '../provider/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-details';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadProducts = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
        appBar: AppBar(
          title: Text(loadProducts.title),
        ),
        body:  
    //     CustomScrollView(
    //   slivers: <Widget>[
    //     SliverAppBar(
    //       expandedHeight: 300,
    //       pinned: true,
    //       flexibleSpace: FlexibleSpaceBar(
    //         title:  Text(
    //           loadProducts.title,
    //         ),
    //         background: Hero(
    //           tag: loadProducts.id,
    //           child: Image.network(
    //             loadProducts.imageUrl,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //     ),
    //     SliverList(
    //       delegate: SliverChildListDelegate(
    //         [
    //           SizedBox(
    //             height: 15,
    //           ),
    //           Text(
    //             '\$${loadProducts.price}',
    //             style: TextStyle(
    //               color: Colors.lightBlueAccent,
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold,
    //             ),
    //             textAlign: TextAlign.center,
    //           ),
    //           SizedBox(height: 10),
    //           Container(
    //             padding: EdgeInsets.all(10),
    //             width: double.infinity,
    //             child: Text(
    //               loadProducts.description,
    //               textAlign: TextAlign.center,
    //               softWrap: true,
    //             ),
    //           ),
    //           SizedBox(height: 800,),
    //         ],
    //       ),
    //     ),
    //   ],
    // )
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Hero(
                  tag: loadProducts.id,
                  child: Image.network(
                    loadProducts.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '\$${loadProducts.price}',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Text(
                  loadProducts.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              )
            ],
          ),
        ),
        );
  }
}
