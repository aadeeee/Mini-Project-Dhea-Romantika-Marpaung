import 'package:flutter/material.dart';
import 'package:store_app/const/format.dart';

class TunaiProvider extends ChangeNotifier {
  int _totalHarga = 0;
  int _jumlahUang = 0;
  int _kembalian = -1;

  int _hargaPas = 0;
  bool _chipStatus = false;
  TextEditingController jumlahUangController = TextEditingController();
  TextEditingController kembalianController = TextEditingController();

  get getJumlahUang => _jumlahUang;

  get getKembalian => _kembalian;

  get getChipStatus => _chipStatus;

  get getHargaPas => _hargaPas;

  set setHargaPas(value) {
    _hargaPas = value;
    notifyListeners();
  }

  set setChipStatus(value) {
    _chipStatus = value;
    notifyListeners();
  }

  set setTotalHarga(value) {
    _totalHarga = value;
    notifyListeners();
  }

  set setKembalianHarga(value) {
    _kembalian = value;
    notifyListeners();
  }

  set setJumlahUang(value) {
    _jumlahUang = value;
    notifyListeners();
  }

  setKembalian() {
    if (_jumlahUang < _totalHarga) {
      _kembalian = -1;
    } else {
      _kembalian = _jumlahUang - _totalHarga;
    }
    kembalianController.text =
        _kembalian == 0 ? '-' : formatCurrency.format(_kembalian);
    notifyListeners();
  }
}
