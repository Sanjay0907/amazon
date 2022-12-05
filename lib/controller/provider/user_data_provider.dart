import 'package:flutter/material.dart';
import '../../model/user_model.dart';

class UserDataProvider extends ChangeNotifier {
  UserModel userModel = UserModel(
    id: '',
    email: '',
    name: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  updateUserModel(String user) {
    // log('the user is $user');
    userModel = UserModel.fromJson(user);
    notifyListeners();
  }

  setUserFromModel(UserModel user) {
    userModel = user;
    notifyListeners();
  }
}
