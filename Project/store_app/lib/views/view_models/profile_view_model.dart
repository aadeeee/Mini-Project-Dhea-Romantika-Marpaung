import 'package:flutter/material.dart';

class ProfilProvider extends ChangeNotifier {
  bool _switchValue = false;

  bool get getterswitchvalue => _switchValue;

  set setterswitchValue(val) {
    _switchValue = val;
    notifyListeners();
  }

  final ThemeData _darkTheme =
      ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark);

  final ThemeData _lightTheme =
      ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light);

  ThemeData getTheme() {
    return getterswitchvalue ? _darkTheme : _lightTheme;
  }
}
