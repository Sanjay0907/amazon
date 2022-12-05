import 'package:amazon/constants/constants.dart';

String baseURL = 'http://192.168.87.88:3000';
Uri signupURL = Uri.parse('$baseURL/api/signup');
Uri signinURL = Uri.parse('$baseURL/api/signin');
Uri tokenValidationURL = Uri.parse('$baseURL/tokenIsValid');
Uri userDataURL = Uri.parse('$baseURL/userData');
Uri addProductURL = Uri.parse('$baseURL/admin/add-product');
Uri getProductsURL = Uri.parse('$baseURL/admin/get-products');
Uri deleteProductsURL = Uri.parse('$baseURL/admin/delete-product');
Uri ratingURL = Uri.parse('$baseURL/api/rate-product');
Uri addToCartURL = Uri.parse('$baseURL/api/add-to-cart');
Uri removeFromCartURL = Uri.parse('$baseURL/api/remove-from-cart');
final header = {"Content-Type": "application/json; charset=UTF-8"};
