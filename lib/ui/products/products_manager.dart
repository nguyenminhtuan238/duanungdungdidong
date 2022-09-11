import 'package:flutter/cupertino.dart';

import '../../models/product.dart';
class ProductManager{
  final List<Product> _item =[
    Product(
    title: "Red Shirt", 
    description: "A red Shirt-it is pretty red!", 
    price: 29.99, 
    imageUrl:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFB_KR5XK667rx63rJIemNmW7GN_ygRoglBk_TPoPM4yZVDGU2jwZtxr7jT9t5aDrVnQE&usqp=CAU ")];
  int get itemCount{
    return _item.length;
  }
  List<Product> get items{
    return[..._item];
  }
  List<Product> get favoriteItems{
    return _item.where((prodItem)=>prodItem.isFavorite).toList();
  }
}