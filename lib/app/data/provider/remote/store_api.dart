import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:thor_flutter/app/data/model/category.dart';
import 'package:thor_flutter/app/data/model/mainscreen.dart';
import 'package:thor_flutter/app/data/model/product.dart';

class StoreAPI {
  final Dio _dio = Get.find<Dio>();

  Future<MainScreen> requestMainScreenProducts() async {
    var response = await _dio.get('/store/product-main');
    return MainScreen.fromJson(response.data['data']);
  }

  Future<List<Product>> requestProductsByCategory(int id) async {
    var response = await _dio.get('/store/productsbycategory/$id');
    return (response.data['data'] as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }

  Future<List<Category>> requestRootCategories() async {
    var response = await _dio.get('/categories/rootcategories');
    return (response.data['data'] as List)
        .map((e) => Category.fromJson(e))
        .toList();
  }

  Future<List<Category>> requestChildrenCategories(int id) async {
    var response = await _dio.get('/categories/firstdescendentcategories/$id');
    return (response.data['data'] as List)
        .map((e) => Category.fromJson(e))
        .toList();
  }

  Future<Product> requestProductDetail(int id) async {
    var response = await _dio.get('/store/product-details/$id');
    return Product.fromJson(response.data['data']);
  }

  Future<List<Product>> requestFavorites() async {
    var response = await _dio.get('/favorites/products');
    print(response);
    return (response.data['data'] as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }

  Future<void> addToFavorites() async {}

  Future<void> removeFromFavorites() async {}

  Future<void> destroyFavorites() async {}
}
