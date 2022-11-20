import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import 'book_products_detail_screen.dart';
import 'reservations_manager.dart';

class BookProductsGridTile extends StatefulWidget {
  const BookProductsGridTile(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  State<BookProductsGridTile> createState() => _BookProductsGridTileState();
}

class _BookProductsGridTileState extends State<BookProductsGridTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
            footer: buildGridFooterBar(context),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    BookProductDetailScreen.routeName,
                    arguments: widget.product.id,
                  );
                },
                child: Image.network(
                  widget.product.imageURL,
                  fit: BoxFit.cover,
                ))));
  }

  Widget buildGridFooterBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
              color: Colors.black.withOpacity(0.5),
              height: 35,
      child: GridTileBar(
        title: Text(widget.product.title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        subtitle: Text('\$${widget.product.price}',
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Color.fromARGB(255, 207, 207, 207),
            )),
        trailing: IconButton(
          icon: const Icon(
            Icons.add_circle_outline,
          ),
          onPressed: () {
            final cart = context.read<ReservationsManager>();
            cart.addItem(widget.product, 1);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: const Text('Dish added to table'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(widget.product.id!);
                    },
                  )));
          },
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
