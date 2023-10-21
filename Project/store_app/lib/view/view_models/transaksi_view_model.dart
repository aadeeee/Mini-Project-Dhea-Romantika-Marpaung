import 'package:flutter/material.dart';
import 'package:store_app/models/produk_model.dart';
import 'package:store_app/models/transaksi_model.dart';
import 'package:store_app/service/transaksi_service.dart';
import 'package:store_app/view/view_models/produk_view_model.dart';

class TransaksiProvider extends ChangeNotifier {
  late final ProdukProvider produkProvider;
  final service = TransaksiApiService();
  List<Transaksi> transaksiList = [];

  Future<void> getData() async {
    try {
      final data = await service.fetchTransaksi();
      transaksiList = data;
      notifyListeners();
    } catch (error) {
      throw Exception('Gagal mengambil data dari API: $error');
    }
  }

  Future<void> addTransaksi(
      {required String metodePembayaran,
      required int qty,
      required int price,
      required String namaProduk}) async {
    try {
      final nomorAntrian = transaksiList.length + 1;

      await service.addTransaksi(
        nomorAntrian: nomorAntrian,
        metodePembayaran: metodePembayaran,
        qty: qty,
        price: price,
        namaProduk: namaProduk,
      );
      await getData();
    } catch (error) {
      throw Exception('Gagal menambahkan transaksi: $error');
    }
  }

  Future<void> updateTransaksi({
    required String id,
  }) async {
    try {
      await service.updateTransaksi(id);
      await getData();
    } catch (error) {
      throw Exception('Gagal Mengubah transaksi: $error');
    }
  }

  int getTotalPenjualan() {
    int total = 0;
    for (var transaksi in transaksiList) {
      if (transaksi.inProcess == false) {
        total += transaksi.qty * transaksi.price;
      }
    }

    return total;
  }

  int getTotalProdukTerjual() {
    int total = 0;
    for (var transaksi in transaksiList) {
      if (transaksi.inProcess == false) {
        total += transaksi.qty;
      }
    }
    return total;
  }

  String selectedMetodePembayaran = "Tunai";
  List<String> metodePembayaran = ["Tunai", "OVO", "DANA", "GoPay"];
  void setSelectedMetodePembayaran(String newValue) {
    selectedMetodePembayaran = newValue;
    notifyListeners();
  }


  Future<void> transaksiSelesai(String idTransaksi, List<Produk> produkData) async {
    var currentTransaksi = transaksiList.firstWhere(
      (transaksi) => transaksi.id == idTransaksi,
    );

    currentTransaksi.inProcess = false;
    for (var produk in produkData) {
      for (var transaksi in transaksiList) {
        if (transaksi.namaProduk == produk.namaProduk) {
          produk.stock -= transaksi.qty;
          await produkProvider.updateProdukStock(produk.id, produk.stock);
        }
      }
    }

    notifyListeners();
  }
}
