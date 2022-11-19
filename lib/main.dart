import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'ui/screen.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => AuthManager(),
          ),
          ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
              create: (ctx) => ProductsManager(),
              update: (ctx, authManager, productsManager) {
                productsManager!.authToken = authManager.authToken;
                return productsManager;
              }),
          ChangeNotifierProvider(
            create: (ctx) => CartManager(),
          ),
          ChangeNotifierProxyProvider<AuthManager, ReservationsManager>(
              create: (ctx) => ReservationsManager(),
              update: (ctx, authManager, reservationsManager) {
                reservationsManager!.authToken = authManager.authToken;
                return reservationsManager;
              }),
          ChangeNotifierProvider(
            create: (ctx) => OrdersManager(),
          ),
        ],
        child: Consumer<AuthManager>(builder: (ctx, authManager, child) {
          return MaterialApp(
            title: 'My Restaurant',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Colors.orange,
                fontFamily: 'Lato',
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.orange,
                ).copyWith(
                  secondary: Colors.deepOrange,
                )),
            home: authManager.isAuth
                ? const ProductsOverviewScreen()
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: ((context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen();
                    })),
            routes: {
              ReservationScreen.routeName: (ctx) => const ReservationScreen(),
              CartScreen.routeName: (ctx) => const CartScreen(),
              OrdersScreen.routeName: (ctx) => const OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == ProductDetailScreen.routeName) {
                final productId = settings.arguments as String;
                return MaterialPageRoute(builder: (ctx) {
                  return ProductDetailScreen(
                    ctx.read<ProductsManager>().findById(productId),
                  );
                });
              }
              if (settings.name == EditProductScreen.routeName) {
                final productId = settings.arguments as String?;
                return MaterialPageRoute(builder: (ctx) {
                  return EditProductScreen(
                    productId != null
                        ? ctx.read<ProductsManager>().findById(productId)
                        : null,
                  );
                });
              }
              if (settings.name == EditTableScreen.routeName) {
                final tableId = settings.arguments as String?;
                return MaterialPageRoute(builder: (ctx) {
                  return EditTableScreen(
                    tableId != null
                        ? ctx.read<ReservationsManager>().findById(tableId)
                        : null,
                  );
                });
              }
              if (settings.name == BookScreen.routeName) {
                final tableId = settings.arguments as String;
                final productId = settings.arguments as String;
                return MaterialPageRoute(builder: (ctx) {
                  return BookScreen(
                    ctx.read<ReservationsManager>().findById(tableId),
                  );
                });
              }
              return null;
            },
          );
        }));
  }
}
