import 'dart:developer';
import 'package:amazon/controller/services/admin_services.dart';
import 'package:amazon/model/product_model.dart';
import 'package:flutter/widgets.dart';

class AdminProductsProvider extends ChangeNotifier {
  bool isLoading = true;
  List<ProductModel> products = [];
  AdminProductsProvider() {
    fetchData();
  }
  fetchData() async {
    List<dynamic> data = await AdminServices.fetchProducts();
    List<ProductModel> temp = [];

    for (var prod in data) {
      ProductModel productModel = ProductModel.fromMap(prod);
      temp.add(productModel);
    }
    products = temp;
    isLoading = false;
    // log(products.toString());
    notifyListeners();
  }
}
