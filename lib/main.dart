import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myshop/models/product.dart';
import 'package:provider/provider.dart';
import 'ui/screens.dart';
import 'package:provider/provider.dart';
Future<void> main() async{
  await dotenv.load();
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
          create: (context)=>AuthManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager,ProductManager>(
          create: (ctx)=>ProductManager(),
          update: (ctx,authmanager,productManager){
            productManager!.autoToken =authmanager.authToken;
            return productManager;
          },
        ),
        ChangeNotifierProvider(
          create: (ctx)=> CartManager(),
        ),
         ChangeNotifierProvider(
          create: (ctx)=> OrdersManager(),
        ),
      ],
      child: Consumer<AuthManager>(
        builder: (context,AuthManager,child) {
          return MaterialApp(
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
            home: AuthManager.isAuth? const ProductsOverviewScreen():FutureBuilder(
              future: AuthManager.tryAutoLogin(),
              builder: (context, snapshot) {
                return snapshot.connectionState==ConnectionState.waiting  
                  ? const SplashScreen()
                  : const AuthScreen();
              },
            ),
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
          );
        }
      ), 
    );
  }
}


 