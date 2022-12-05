import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/controller/provider/admin_products_provider.dart';
import 'package:amazon/controller/provider/success_provider.dart';
import 'package:amazon/controller/provider/user_data_provider.dart';
import 'package:amazon/controller/services/url_and_headers.dart';
import 'package:amazon/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amazon/constants/common_functions.dart';
import 'package:amazon/model/product_model.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminServices {
  static sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      UserModel userModel = Provider.of<UserDataProvider>(
        context,
        listen: false,
      ).userModel;
      final cloudinary = CloudinaryPublic('dgvg1jlib', 'n8hhja8j');
      List<String> imageURLs = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: name,
          ),
        );
        imageURLs.add(response.secureUrl);
      }

      ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        category: category,
        price: price,
        images: imageURLs,
      );
      log(userModel.token);
      http.Response response = await http.post(addProductURL,
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": userModel.token,
          },
          body: product.toJson());
      log(response.statusCode.toString());

      ErrorHandling.httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            log('success');

            Provider.of<CheckSuccessProvider>(context, listen: false)
                .updateFields();
            context.read<AdminProductsProvider>().fetchData();
            Navigator.pop(context);
          });
    } catch (e) {
      log(e.toString());
      CommonFunctions.errorToast(
          context: context,
          description: e.toString(),
          givenWidth: 0.8,
          givenHeight: 0.1);
    }
  }

  static fetchProducts() async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    String? token = perfs.getString('x-auth-token');
    try {
      var response = await http.get(
        getProductsURL,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": token!,
        },
      );

      var decodedResponse = jsonDecode(response.body);
      // log(decodedResponse.toString());
      if (response.statusCode == 200) {
        return decodedResponse;
      }
    } catch (e) {
      log('error');
      log(e.toString());
    }
  }

  static deleteProduct(BuildContext context, String id) async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    String? token = perfs.getString('x-auth-token');
    http.Response response = await http.post(
      deleteProductsURL,
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": token!,
      },
      body: jsonEncode({"id": id}),
    );
    log(response.statusCode.toString());
    log(jsonDecode(response.body).toString());
    ErrorHandling.httpErrorHandle(
      response: response,
      context: context,
      onSuccess: () {
        context.read<AdminProductsProvider>().fetchData();
        final decodedResponse = jsonDecode(response.body);
        CommonFunctions.successToast(
          context: context,
          description: 'Successfully deleted ${decodedResponse['name']}',
          givenWidth: 0.8,
          givenHeight: 0.1,
        );
      },
    );
  }
}
