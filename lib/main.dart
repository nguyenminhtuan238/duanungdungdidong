import 'package:flutter/material.dart';
import 'package:myshop/models/product.dart';
import 'package:provider/provider.dart';
import 'ui/screens.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx)=>ProductManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx)=> CartManager(),
        ),
         ChangeNotifierProvider(
          create: (ctx)=> OrdersManager(),
        ),
      ],
      child: MaterialApp(
        title: 'My Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'loto',
          colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          ).copyWith(
          secondary: Colors.deepOrange,
          ),
        ),
        home: const ProductsOverviewScreen(),
        routes: {
          CartScreen.routeName:
          (ctx)=>const CartScreen(),
          OrdersScreen.routeName:
          (ctx)=>const OrdersScreen(),
          UserProductsScreen.routeName:
          (ctx)=>const UserProductsScreen(),
        },
        onGenerateRoute: (settings){
          if(settings.name == EditProductScreen.routeName){
            final productId = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (ctx){
                return EditProductScreen(
                  productId != null
                 ?ctx.read<ProductManager>().findById(productId)
                 :null,
                );
              },
            );
          }
        return null;
        },
      ), 
    );
  }
}


 