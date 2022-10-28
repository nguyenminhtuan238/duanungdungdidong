import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myshop/models/auth_token.dart';
import '../../models/product.dart';
import '../../services/products_service.dart';
class ProductManager with ChangeNotifier{
   List<Product> _item =[];
  final ProductsService _productsService;
  ProductManager([AuthToken?authToken]):_productsService=ProductsService(authToken);
  set autoToken(AuthToken?authToken){
    _productsService.autoToken= authToken;
  }
  Future<void> fetchProducts([bool filterByUser = false]) async{
    _item = await _productsService.fetchProducts(filterByUser);
    notifyListeners();
  }
  int get itemCount{
    return _item.length;
  }
  List<Product> get items{
    return[..._item];
  }
  List<Product> get favoriteItems{
    return _item.where((prodItem)=>prodItem.isFavorite).toList();
  }
  Product findById(String id){
    return _item.firstWhere((prod) => prod.id == id);
  }
  Future<void> addProduct(Product product) async{
    final newProduct=await _productsService.addProduct(product);
    if(newProduct != null){
       _item.add(newProduct);
    notifyListeners();
    }
  }
  Future<void> updateProduct(Product product) async{
    final index=_item.indexWhere((item) => item.id == product.id);
    if(index >= 0){
      if(await _productsService.updateProducts(product)){
         _item[index]=product;
        notifyListeners();
      } 
    }
  }
  void toggleFavoriteStatus(Product product){
    final saveStatus=product.isFavorite;
    product.isFavorite=!saveStatus;
  }
  Future<void> deleteProduct(String id) async{
    final index=_item.indexWhere((item) => item.id==id);
    Product? existingProduct=_item[index];
    _item.removeAt(index);
    notifyListeners();
    if(!await _productsService.deleteProduct(id)){
      _item.insert(index, existingProduct);
      notifyListeners();
    }
  }
}