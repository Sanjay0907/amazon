import 'dart:convert';
import 'package:amazon/constants/common_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ErrorHandling {
  static httpErrorHandle({
    required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess,
  }) {
    switch (response.statusCode) {
      case 200:
        onSuccess();
        break;
      case 400:
        CommonFunctions.warningToast(
          context: context,
          description: jsonDecode(response.body)['msg'],
          givenWidth: 0.85,
          givenHeight: 0.1,
        );
        break;
      case 500:
        CommonFunctions.errorToast(
          context: context,
          description: json.decode(response.body)['msg'],
          givenWidth: 0.85,
          givenHeight: 0.1,
        );

        // );
        break;
      default:
        CommonFunctions.errorToast(
          context: context,
          description: jsonDecode(response.body).toString(),
          givenWidth: 0.85,
          givenHeight: 0.1,
        );
        break;
    }
  }
}
