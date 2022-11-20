import 'package:flutter/material.dart';
import 'package:flutter_application_myrestaurant/ui/screen.dart';
import 'package:provider/provider.dart';
import 'dishes_grid.dart';
import '../shared/app_drawer.dart';
import 'top_right_badge.dart';

enum FilterOptions { favorites, all }

class DishesOverviewScreen extends StatefulWidget {
  const DishesOverviewScreen({super.key});

  @override
  State<DishesOverviewScreen> createState() => _DishesOverviewScreenState();
}

class _DishesOverviewScreenState extends State<DishesOverviewScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchDishes;

  @override
  void initState() {
    super.initState();
    _fetchDishes = context.read<DishesManager>().fetchDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyRestaurant'),
        actions: <Widget>[
          buildDishFilterMenu(),
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      backgroundColor: const Color.fromARGB(255, 255, 237, 205),
      body: FutureBuilder(
        future: _fetchDishes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ValueListenableBuilder<bool>(
                valueListenable: _showOnlyFavorites,
                builder: (context, onlyFavorites, child) {
                  return DishesGrid(onlyFavorites);
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(builder: (ctx, cartManager, child) {
      return TopRightBadge(
          data: cartManager.dishCount,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: (() {
              Navigator.of(ctx).pushNamed(CartScreen.routeName);
            }),
          ));
    });
  }

  Widget buildDishFilterMenu() {
    return PopupMenuButton(
        onSelected: (FilterOptions selectedValue) {
          if (selectedValue == FilterOptions.favorites) {
            _showOnlyFavorites.value = true;
          } else {
            _showOnlyFavorites.value = false;
          }
        },
        icon: const Icon(
          Icons.more_vert,
        ),
        itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text("Only favorites"),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show All'),
              )
            ]);
  }
}
