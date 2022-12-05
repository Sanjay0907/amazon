import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'url_and_headers.dart';

class SearchServices {
  static fetchSearchProduct(String searchQuery) async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    String? token = perfs.getString('x-auth-token');
    try {
      var response = await http.get(
        Uri.parse('$baseURL/api/products/search/$searchQuery'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": token!,
        },
      );

      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log('the status code is ${response.statusCode.toString()}');
        log(decodedResponse.toString());
        return decodedResponse;
      }
    } catch (e) {
      log('error');
      log(e.toString());
    }
  }
}
