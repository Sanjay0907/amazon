import 'dart:convert';
import 'dart:developer';
import 'package:amazon/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'url_and_headers.dart';

class FetchProduct {
  static fetchCategory(String cat) async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    String? token = perfs.getString('x-auth-token');
    try {
      log('in service $cat');
      var response = await http.get(
        Uri.parse('$baseURL/api/products?category=$cat'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": token!,
        },
      );

      var decodedResponse = jsonDecode(response.body);
      // log(decodedResponse.toString());
      if (response.statusCode == 200) {
        log(decodedResponse.toString());
        log(decodedResponse.toString());
        return decodedResponse;
      }
    } catch (e) {
      log('error');
      log(e.toString());
    }
  }

  static fetchdealofTheday() async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    String? token = perfs.getString('x-auth-token');
    try {
      var response = await http.get(
        Uri.parse('$baseURL/api/deal-of-the-day'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": token!,
        },
      );

      var decodedResponse = jsonDecode(response.body);
      log(decodedResponse.toString());
      if (response.statusCode == 200) {
        return decodedResponse;
      }
    } catch (e) {
      log('error');
      log(e.toString());
    }
  }
}
