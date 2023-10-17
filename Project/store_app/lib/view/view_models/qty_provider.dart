import 'package:flutter/material.dart';

class QtyProdukProvider extends ChangeNotifier {
  int _qty = 1;

  get getQty => _qty;

  set setQty(value) {
    _qty = value;
    notifyListeners();
  }
}
