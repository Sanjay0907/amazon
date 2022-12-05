import 'dart:convert';
import 'dart:developer';
import 'package:amazon/controller/services/url_and_headers.dart';
import 'package:amazon/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/common_functions.dart';
import '../../constants/error_handling.dart';
import '../../model/user_model.dart';
import '../provider/user_data_provider.dart';

class ProductDetailsServices {
  static rateProduct({
    required BuildContext context,
    required ProductModel model,
    required double rating,
  }) async {
    try {
      UserModel userModel = Provider.of<UserDataProvider>(
        context,
        listen: false,
      ).userModel;

      http.Response response = await http.post(
        ratingURL,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userModel.token,
        },
        body: jsonEncode(
          {
            "id": model.id,
            "rating": rating,
          },
        ),
      );

      ErrorHandling.httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      log(e.toString());
      CommonFunctions.errorToast(
          context: context,
          description: e.toString(),
          givenWidth: 0.8,
          givenHeight: 0.1);
    }
  }

  static addToCart({
    required BuildContext context,
    required ProductModel model,
  }) async {
    try {
      UserModel userModel = Provider.of<UserDataProvider>(
        context,
        listen: false,
      ).userModel;
      var userProvider = Provider.of<UserDataProvider>(
        context,
        listen: false,
      );
      http.Response response = await http.post(
        addToCartURL,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userModel.token,
        },
        body: jsonEncode(
          {
            "id": model.id,
          },
        ),
      );

      ErrorHandling.httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          UserModel user = userModel.copyWith(
            cart: jsonDecode(
              response.body,
            )['cart'],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      log(e.toString());
      CommonFunctions.errorToast(
          context: context,
          description: e.toString(),
          givenWidth: 0.8,
          givenHeight: 0.1);
    }
  }

  static removeFromCart({
    required BuildContext context,
    required ProductModel model,
  }) async {
    try {
      UserModel userModel = Provider.of<UserDataProvider>(
        context,
        listen: false,
      ).userModel;
      var userProvider = Provider.of<UserDataProvider>(
        context,
        listen: false,
      );
      http.Response response = await http.delete(
        Uri.parse('$baseURL/api/remove-from-cart/${model.id}'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userModel.token,
        },
      );

      ErrorHandling.httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          UserModel user = userModel.copyWith(
            cart: jsonDecode(
              response.body,
            )['cart'],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      log(e.toString());
      CommonFunctions.errorToast(
          context: context,
          description: e.toString(),
          givenWidth: 0.8,
          givenHeight: 0.1);
    }
  }
}
