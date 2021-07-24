import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quatity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quatity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  int get itemCount {
    return items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quatity;
    });
    return total;
  }

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (exictingCartItem) => CartItem(
                id: exictingCartItem.id,
                title: exictingCartItem.title,
                price: exictingCartItem.price,
                quatity: exictingCartItem.quatity + 1,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quatity: 1,
              ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quatity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quatity: existingCartItem.quatity-1,
        ),
      );
    } else {
      _items.remove(productId);
    }
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
