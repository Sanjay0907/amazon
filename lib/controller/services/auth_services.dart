// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:amazon/constants/common_functions.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/controller/services/url_and_headers.dart';
import 'package:amazon/model/user_model.dart';
import 'package:amazon/view/admin_screens/admin_screen.dart';
import 'package:amazon/view/user_screens/user_app_screens.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/user_data_provider.dart';

class AuthServices {
  static signup({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    log('$email , $password, $name');
    try {
      UserModel usermodel = UserModel(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response response =
          await http.post(signupURL, body: usermodel.toJson(), headers: header);
      log('the response code is ${response.statusCode.toString()}');
      ErrorHandling.httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          CommonFunctions.successToast(
            context: context,
            description: 'Congrats! Account Created',
            givenWidth: 0.85,
            givenHeight: 0.1,
          );
        },
      );
    } catch (e) {
      CommonFunctions.errorToast(
        context: context,
        description: e.toString(),
        givenWidth: 0.85,
        givenHeight: 0.1,
      );
      log(e.toString());
    }
  }

  static signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    log('$email , $password');
    try {
      UserModel usermodel = UserModel(
        id: '',
        name: '',
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response response =
          await http.post(signinURL, body: usermodel.toJson(), headers: header);
      log('the response code is ${response.statusCode.toString()}');
      log(response.body);
      ErrorHandling.httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          CommonFunctions.successToast(
            context: context,
            description: 'Successfully signed in',
            givenWidth: 0.85,
            givenHeight: 0.1,
          );
          Provider.of<UserDataProvider>(context, listen: false)
              .updateUserModel(response.body);
          SharedPreferences perfs = await SharedPreferences.getInstance();

          await perfs.setString(
              'x-auth-token', jsonDecode(response.body)['token']);
          String type = Provider.of<UserDataProvider>(context, listen: false)
              .userModel
              .type;
          type == 'User'
              ? Navigator.pushNamedAndRemoveUntil(
                  context,
                  UserAppScreens.routeName,
                  (route) => false,
                )
              : Navigator.pushNamedAndRemoveUntil(
                  context,
                  AdminAppScreens.routeName,
                  (route) => false,
                );
        },
      );
    } catch (e) {
      CommonFunctions.errorToast(
        context: context,
        description: e.toString(),
        givenWidth: 0.85,
        givenHeight: 0.1,
      );
      log(e.toString());
    }
  }

  static getUserData(BuildContext context) async {
    try {
      SharedPreferences perfs = await SharedPreferences.getInstance();
      String? token = perfs.getString('x-auth-token');

      if (token == null) {
        perfs.setString('x-auth-token', '');
      }
      var response = await http.post(tokenValidationURL, headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": token!
      });

      var decodedResponse = jsonDecode(response.body);
      // print(decodedResponse);
      if (decodedResponse == true) {
        // log('Inside');
        http.Response response = await http.get(
          userDataURL,
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token
          },
        );
        return response.body;
      }
      return null;
    } catch (e) {
      log(e.toString());
    }
  }
}
