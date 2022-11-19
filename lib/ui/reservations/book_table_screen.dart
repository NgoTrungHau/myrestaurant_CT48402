import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../models/table.dart';
import '../products/products_manager.dart';
import 'book_products_grid.dart';
import 'reservations_manager.dart';
import 'table_item_card.dart';

class BookScreen extends StatefulWidget {
  static const routeName = '/book-table';

  const BookScreen(
    this.table, {
    super.key,
  });

  final TableB table;

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  TableB? table;

  int i = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      table = widget.table;
    });
  }

  @override
  Widget build(BuildContext context) {
    final table = context.watch<ReservationsManager>();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.table.title),
        ),
        body: Column(children: <Widget>[
          buildCartSummary(table, context),
          const SizedBox(height: 10),
          Expanded(
            child: buildTableDetails(table),
          ),
          const Text('Choosing dish',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Expanded(
            child: buildChooseDetails(table),
          )
        ]));
  }

  Widget buildTableDetails(ReservationsManager table) {
    return ListView(
      children: table.productEntries
          .map(
            (entry) => TableItemCard(
              productId: entry.key,
              tableItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildChooseDetails(ReservationsManager table) {
    final products = context.select<ProductsManager, List<Product>>(
        (productsManager) => productsManager.items);
    // final tableItem = context.select<ReservationsManager, List<TableItem>>(
    //   (reservationsManager) => reservationsManager.items
    // );
    // return ListView.builder(
    //   padding: const EdgeInsets.all(10.0),
    //   itemCount: products.length,
    //   itemBuilder: (ctx, i) => FoodListTile(products[i]),
    // );
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => BookProductsGridTile(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }

  Widget buildCartSummary(ReservationsManager table, BuildContext context) {
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
                      '\$${table.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6?.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: table.totalAmount <= 0
                        ? null
                        : () {
                            context.read<ReservationsManager>().addReservation(
                                  table.products,
                                  table.totalAmount,
                                  widget.table.title,
                                );
                            table.clear();
                          },
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    child: const Text('BOOK NOW',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ])));
  }
}