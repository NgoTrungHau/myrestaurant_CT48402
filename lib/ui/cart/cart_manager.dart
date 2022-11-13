import 'package:flutter/material.dart';

import '../../models/cart_item.dart';
import '../../models/product.dart';

class CartManager with ChangeNotifier {
  Map<String, CartItem> _items = {
    'p1': CartItem(
      id: 'c1',
      title: 'Phở',
      price: 3.99,
      quantity: 2,
      imageUrl: "https://cdn.tgdd.vn/Files/2022/01/25/1412805/cach-nau-pho-bo-nam-dinh-chuan-vi-thom-ngon-nhu-hang-quan-202201250313281452.jpg",
    ),
  };

  int get productCount {
    return _items.length;
  }

  List<CartItem> get products {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
     });
     return total;
  }

  
  double totalAmountItem(String productId) {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      if (key == productId) {
        total += cartItem.price * cartItem.quantity;
      }
     });
     return total;
  }

  void addItem(Product product, int i) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id!,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity + i,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id!,
        () => CartItem(
          id: 'c${DateTime.now().toIso8601String()}',
          title: product.title,
          price: product.price,
          quantity: i,
          imageUrl: product.imageURL,
        )
      );
    }
    notifyListeners();
  }

  void plusQuantity(String productId, CartItem cartItem) {
    _items.update(
      productId,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity + 1,
        ),
    );
  }

  void minusQuantity(BuildContext context, String productId, CartItem cartItem) {
    _items.forEach((key, cartItem) {
      if (key == productId) {
        if (cartItem.quantity > 1) {
          _items.update(
            productId,
              (existingCartItem) => existingCartItem.copyWith(
                quantity: existingCartItem.quantity - 1,
              ),
          );
        } else {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Are you sure?'),
              content: Text('Do you want to remove the item from the cart?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                    removeItem(productId);
                  },
                ),
              ],
            ),
          );
        }
      }
    });
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem (String productId) {
    if(!_items.containsKey(productId)) {
      return;
    }
    if(_items[productId]?.quantity as num > 1) {
      _items.update(
        productId,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity - 1,
        )
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  CartItem? getCartItem(String productId) {
    return _items[productId];
  }


  void clear() {
    _items = {};
    notifyListeners();
  }
}