import 'package:amazon/controller/services/search_services.dart';
import 'package:amazon/model/product_model.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  bool isLoading = true;
  List<ProductModel> products = [];
  fetchSearchProduct(String searchQuery) async {
    List<ProductModel> temp = [];

    var searchedResult = await SearchServices.fetchSearchProduct(searchQuery);
    for (var data in searchedResult) {
      ProductModel productModel = ProductModel.fromMap(data);
      temp.add(productModel);
    }
    isLoading = false;
    products = temp;
    notifyListeners();
  }

  setToDefault() {
    isLoading = true;
    products = [];
    notifyListeners();
  }
}
