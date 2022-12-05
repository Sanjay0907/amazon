import 'package:flutter/widgets.dart';

class CheckSuccessProvider extends ChangeNotifier {
  bool success = false;

  updateFields() {
    success = true;
    notifyListeners();
    Future.delayed(
      const Duration(seconds: 5),
      () => rollBack(),
    );
  }

  rollBack() {
    success = false;
    notifyListeners();
  }
}
