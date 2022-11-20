import 'package:flutter/material.dart';

import '../../models/product.dart';

import '../products/products_detail_screen.dart';


class FoodListTile extends StatefulWidget {

  const FoodListTile(
    this.product, {
      super.key, 
    }
  );


  final Product product;

  @override
  State<FoodListTile> createState() => _FoodListTileState();
}

class _FoodListTileState extends State<FoodListTile> {
  Product? product ;


  @override
  void initState() {
    super.initState();
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
  }
}