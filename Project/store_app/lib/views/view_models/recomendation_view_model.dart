import 'package:flutter/material.dart';

class RecomendationProvider extends ChangeNotifier {
  String produkRecomendations = '';

  void updateProdukRecomendations(String newData) {
    produkRecomendations = newData;
    notifyListeners();
  }
}
