import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../cart/cart_manager.dart';


int i=1;

@override
void initState() {}

Future<bool?> showConfirmDialog(BuildContext context, String message){
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Are you sure?'),
      content: Text(message),
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
          },
        ),
      ],
    ),
  );
}

Future<bool?> showAddNumberDialog(BuildContext context, Product product){
  final cart = context.read<CartManager>();
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Choose amount'),
            content: 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    color: Colors.red,
                    icon: new Icon(Icons.remove, size:33),
                    onPressed: (() {
                      setState(() {
                        i--;
                      });
                      print(i);
                    }),
                  ),
                  Container(
                    width: 50.0,
                    height: 24.0,
                    child: Center(
                      // child: Text(
                      //   '${i}',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: Colors.black,
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: TextEditingController()
                          ..text = '${i}',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          setState(() {
                            final number = int.parse(value);
                            i = number;
                          });
                        },
                      )
                    ),
                  ),
                  IconButton(
                    color: Colors.blue,
                    icon: new Icon(Icons.add, size:33),
                    onPressed: (() {
                      setState(() {
                        i++;
                      });
                      print(i);
                    }),
                  )
                ]
              ),
            actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          child: const Text(
                            'Cancel',
                            style:TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            i=1;
                          },
                        ),
                        SizedBox(width: 80),
                        TextButton(
                          child: const Text(
                            'Add to cart',
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            cart.addItem(product,i);
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: const Text('Item added to cart'),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'UNDO',
                                    onPressed:() {
                                      cart.removeSingleItem(product.id!);
                                    },
                                  )
                                )
                              );
                            i=1;
                          },
                        ),
                      ]
                    ),
                  ],
          );
        }
      );
    },
  );
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('An Error Occurred!'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}
