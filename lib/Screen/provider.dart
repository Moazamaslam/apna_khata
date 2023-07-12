import 'package:flutter/cupertino.dart';

class StatProvider extends ChangeNotifier {
  double total = 0;
  void setTotal(double value) {
    total = value;
    notifyListeners();
  }
}
