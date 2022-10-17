import 'package:flutter/material.dart';
import 'package:myshop/ui/products/products_manager.dart';
import '../../models/product.dart';
import 'package:provider/provider.dart';
class UserProductListTile extends StatelessWidget {
  final Product product;
  const UserProductListTile(this.product,{ super.key });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage:NetworkImage(product.imageUrl) ,
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children:<Widget> [
            buildDeleteButton(context),
            buildEditButton(context),
          ],
        ),
      ),
    );
  }
  Widget buildDeleteButton(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: (){
        context.read<ProductManager>().deleteProduct(product.id!);
        ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Product deleted',
              textAlign: TextAlign.center,
            ),
          ),
        );
    }, 
    color: Theme.of(context).errorColor,
    );

  }
  Widget buildEditButton(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        print('go to edit product screen');
    }, 
    color: Theme.of(context).primaryColor,
    );
    
  }
}