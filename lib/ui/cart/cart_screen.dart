import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../orders/orders_manager.dart';
import 'cart_manager.dart';
import 'cart_item_card.dart';

StreamController<int> streamController = StreamController<int>();

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          buildDeleteAllButton(cart)
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 237, 205),
      body: Column(
        children: <Widget>[
          buildCartSummary(cart, context),
          const SizedBox(height: 10),
          Expanded(
            child: buildCartDetails(cart),
          )
        ],
      ),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.dishEntries
          .map(
            (entry) => CartItemCard(
              dishId: entry.key,
              cartItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(15),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6?.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: cart.totalAmount <= 0
                        ? null
                        : () {
                            context.read<OrdersManager>().addOrder(
                                  cart.dishes,
                                  cart.totalAmount,
                                );
                            cart.clear();
                          },
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    child: const Text('ORDER NOW',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ])));
  }
  Widget buildDeleteAllButton(CartManager cart) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        cart.clear();
      },
    );
  }
}
