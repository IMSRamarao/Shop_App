import '../widgets/app_drawer.dart';

import '../provider/orders.dart' show Orders;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   var _isloading = false;
//   @override
//   void initState() {
//     // Future.delayed(Duration.zero).then((_) async {

//     // _isloading = true;
//     //  Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
//     //     setState(() {
//     //   _isloading = false;
//     // });
//     //  });

//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.connectionState == null) {
                return Center(
                  child: Text('Error Acccured'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, ordersData, child) => ListView.builder(
                    itemCount: ordersData.orders.length,
                    itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]),
                  ),
                );
              }
            }
          },
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        ));
  }
}
