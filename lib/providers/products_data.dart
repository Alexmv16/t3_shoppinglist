import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:t3_shoppinglist/models/product.dart';

enum OrderBy { id, name, category, price, iva }

class ProductsData {
  final List<Product> _products;

  ProductsData._(this._products);

  factory ProductsData.fromJson(String jsonData, {OrderBy orderBy = OrderBy.name}) {
    Map<String, dynamic> mapJson = json.decode(jsonData);

    List<dynamic> list = mapJson["products"];

    List<Product> productsList = list.map((element) => Product.fromMap(element)).toList();

    _sortList(productsList, orderBy);

    return ProductsData._(productsList);
  }

  Product getProduct(int index) => _products[index];
  int getSize() => _products.length;

  List<Product> getSelectedProducts() {
    return _products.where((product) => product.isSelected).toList();
  }

  static Future<String> loadJson(BuildContext context, String file) async {
    await Future.delayed(Duration(seconds: 2));
    return await DefaultAssetBundle.of(context).loadString(file);
  }

  static void _sortList(List<Product> list, OrderBy orderBy) {
    switch (orderBy) {
      case OrderBy.id:
        list.sort((prodA, prodB) => prodA.id.compareTo(prodB.id));
        break;
      case OrderBy.name:
        list.sort((prodA, prodB) => prodA.name.compareTo(prodB.name));
        break;
      case OrderBy.category:
        list.sort((prodA, prodB) => prodA.category.compareTo(prodB.category));
        break;
      case OrderBy.price:
        list.sort((prodA, prodB) => prodA.price.compareTo(prodB.price));
        break;
      case OrderBy.iva:
        list.sort((prodA, prodB) => prodA.iva.compareTo(prodB.iva));
        break;
    }
  }
}
