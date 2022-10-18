import 'package:flutter/material.dart';
import '../products/edit_product_screen.dart';
import 'user_product_list_tile.dart';
import 'products_manager.dart';
import '../shared/app_drawer.dart';
import 'package:provider/provider.dart';
class UserProductsScreen extends StatelessWidget {
  static const routeName='/user-products';
  const UserProductsScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    final productsManager=ProductManager();
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Your Products'),
        actions:<Widget> [
          buildAddButton(context),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async => print('refresh products'),
        child: buildUserProductListView(productsManager),
      ),
    );
  }
   Widget buildUserProductListView(ProductManager productManager){
     return Consumer<ProductManager>(
       builder: (ctx, productsManager,child){
         return ListView.builder(
            itemCount: productManager.itemCount,
            itemBuilder: (ctx,i)=>Column(
              children: [
                UserProductListTile(
                  productManager.items[i]
                ),
                const Divider(),
              ],
            ),
          );
        },
     );
   }
   Widget buildAddButton(BuildContext context){
     return IconButton(

       onPressed: (){
         Navigator.of(context).pushNamed(
           EditProductScreen.routeName,
         );
       }, 
       icon: const Icon(Icons.add),
       );
   }
}