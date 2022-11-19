import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../models/table_item.dart';
import '../products/products_detail_screen.dart';
import '../products/products_manager.dart';
import '../shared/dialog_utils.dart';

class FoodListTile extends StatefulWidget {

  const FoodListTile(
    this.product, {
      super.key, 
    }
    // this.tableItem, {
    //   super.key, 
    //   required this.product,
    // }
  );

  // final TableItem tableItem;
  final Product product;

  @override
  State<FoodListTile> createState() => _FoodListTileState();
}

class _FoodListTileState extends State<FoodListTile> {
  // TableItem? tableItem ;
  Product? product ;


  @override
  void initState() {
    // tableItem = widget.tableItem;
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product?.id,
            );
          },
          child: Image.network(
            product!.imageURL,
            fit: BoxFit.cover,
          )
        )
      )
    );
    // return Card(
    //   margin: const EdgeInsets.symmetric(
    //     horizontal: 15,
    //     vertical: 4,
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.all(10),
    //     child: ListTile(
    //       leading: CircleAvatar(
    //         backgroundImage: NetworkImage(widget.product.imageURL),
    //       ),
    //       title: Text(widget.product.title),
    //       subtitle: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Text('Price: \$${widget.product.price}'),
    //           // Text('Total: \$${product.totalAmountItem(widget.productId).toStringAsFixed(2)}'),
    //         ]
    //       ),
    //       trailing: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: <Widget>[
    //           IconButton(
    //             icon: new Icon(Icons.remove, size:30),
    //             color: Colors.red,
    //             onPressed: (() {
    //               // cart.minusQuantity(context,widget.product.id, widget.product);
    //               // setState(() {
    //               //   cartItem = cart.getCartItem(widget.productId);
    //               //   print(cartItem?.quantity);
    //               // });
    //             }),
    //           ),
    //           Container(
    //             width: 20.0,
    //             height: 24.0,
    //             child: Center(
    //               child: Text(
    //                 '0',
    //                 // '${tableItem?.quantity}',
    //                 style: const TextStyle(
    //                   fontSize: 16,
    //                   color: Colors.black,
    //                 ),
    //                 textAlign: TextAlign.center,
    //               ),
    //             ),
    //           ),
    //           IconButton(
    //             color: Colors.blue,
    //             icon: new Icon(Icons.add, size:30),
    //             onPressed: (() {
    //               // cart.plusQuantity(widget.productId, widget.cartItem);
    //               // setState(() {
    //               //   cartItem = cart.getCartItem(widget.productId);
    //               //   print(cartItem?.quantity);
    //               //   });
    //             }),
    //           ),
    //         ]
    //       ),
    //       // child: GestureDetector(
    //       //   onTap: () {
    //       //     Navigator.of(context).pushNamed(
    //       //       ProductDetailScreen.routeName,
    //       //       arguments: widget.product.id,
    //       //     );
    //       //   },
    //       //   child: Image.network(
    //       //     widget.product.imageURL,
    //       //     fit: BoxFit.cover,
    //       //   )
    //       // )
    //     ),
    //   )
    // );
  }
}