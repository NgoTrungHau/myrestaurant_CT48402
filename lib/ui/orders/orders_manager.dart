import 'package:flutter/foundation.dart';

import '../../models/cart_item.dart';
import '../../models/order_item.dart';

class OrdersManager with ChangeNotifier {
  final List<OrderItem> _orders =[
    OrderItem(
      id: 'o1',
      amount: 59.98,
      products: [
        CartItem(
          id: 'c1',
          title: 'Pho',
          price: 49.99,
          quantity: 2,
          imageUrl: "https://cdn.tgdd.vn/Files/2022/01/25/1412805/cach-nau-pho-bo-nam-dinh-chuan-vi-thom-ngon-nhu-hang-quan-202201250313281452.jpg",
        )
      ],
      dateTime: DateTime.now(),
    )
  ];
  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) async {
    _orders.insert(
      0,
      OrderItem(
        id: 'o${DateTime.now().toIso8601String()}',
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      )
    );
    notifyListeners();
  }
}