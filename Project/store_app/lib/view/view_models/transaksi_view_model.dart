import 'package:flutter/material.dart';
import 'package:store_app/models/transaksi_model.dart';
import 'package:store_app/service/transaksi_service.dart';



class TransaksiProvider extends ChangeNotifier {
  final service = TransaksiApiService();
  List<Transaksi> transaksiList = [];

  Future<void> getData() async {
    try {
      final data = await service.fetchTransaksi();
      print(data);
      transaksiList = data;
      notifyListeners();
    } catch (error) {
      throw Exception('Gagal mengambil data dari API: $error');
    }
  }


 
}
