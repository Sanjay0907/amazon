import 'package:amazon/controller/services/fetch_product_services.dart';
import 'package:amazon/model/product_model.dart';
import 'package:flutter/widgets.dart';

class DealOfTheDayProvider extends ChangeNotifier {
  bool isLoading = true;
  List<ProductModel> deals = [];
  DealOfTheDayProvider() {
    fetchDealOfTheDay();
  }
  fetchDealOfTheDay() async {
    var data = await FetchProduct.fetchdealofTheday();
    List<ProductModel> temp = [];
    for (var prod in data) {
      ProductModel product = ProductModel.fromMap(prod);
      temp.add(product);
    }
    deals = temp;
    isLoading = false;
    notifyListeners();
  }
}
