import 'dart:developer';
import 'package:amazon/controller/services/fetch_product_services.dart';
import 'package:amazon/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductsProvider extends ChangeNotifier {
  bool isLoading = true;
  List<ProductModel> products = [];

  fetchData(String category) async {
    log(category);
    List<dynamic> data = await FetchProduct.fetchCategory(category);
    List<ProductModel> temp = [];

    for (var prod in data) {
      ProductModel productModel = ProductModel.fromMap(prod);
      temp.add(productModel);
    }
    products = temp;
    isLoading = false;
    notifyListeners();
  }

  setToDefault() {
    isLoading = true;
    products = [];
    notifyListeners();
    log('set to default');
  }
}
