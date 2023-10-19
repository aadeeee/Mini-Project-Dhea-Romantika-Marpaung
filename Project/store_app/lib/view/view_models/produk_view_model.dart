// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:store_app/models/produk_model.dart';
import 'package:store_app/service/produk_service.dart';

class ProdukProvider extends ChangeNotifier {
  final service = ProdukApiService();
  List<Produk> produkList = [];

  Future<void> getData() async {
    try {
      final data = await service.fetchProduk();
      produkList = data;
      // print(produkList[0].id);
      notifyListeners();
    } catch (error) {
      throw Exception('Gagal mengambil data dari API: $error');
    }
  }

  List<String> get kategoriProduk {
    Set<String> kategoriSet = <String>{};
    for (var produk in produkList) {
      kategoriSet.add(produk.kategori);
    }
    return kategoriSet.toList();
  }

  Future<void> addProduk({
    required String namaProduk,
    required String img,
    required int hargaJual,
    required int hargaBeli,
    required String kategori,
    required String deskripsi,
    required int stock,
  }) async {
    try {
      await service.addProduk(
        namaProduk: namaProduk,
        img: img,
        hargaJual: hargaJual,
        hargaBeli: hargaBeli,
        kategori: kategori,
        deskripsi: deskripsi,
        stock: stock,
      );
      await getData();
    } catch (error) {
      throw Exception('Gagal menambahkan produk: $error');
    }
  }

  Future<void> updateProduk(Produk produk) async {
    try {
      await service.updateProduk(produk);
      await getData();
    } catch (error) {
      throw Exception('Gagal memperbarui produk: $error');
    }
  }

  Future<void> deleteProduk(String id) async {
    try {
      await service.deleteProduk(id);
      await getData();
    } catch (error) {
      throw Exception('Gagal menghapus produk: $error');
    }
  }

  List<Tab> getTabs() {
    List<Tab> tabs = [
      const Tab(
        text: 'Semua Produk',
      ),
      ...kategoriProduk
          .map((category) => Tab(
                text: category,
              ))
          .toList(),
    ];
    return tabs;
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> kategori = [
      const DropdownMenuItem(
          value: "none", child: Text("Pilih Kategori Produk")),
      const DropdownMenuItem(value: "ATK", child: Text("ATK")),
      const DropdownMenuItem(
          value: "Craft Supply", child: Text("Craft Supply")),
      const DropdownMenuItem(value: "Jahit", child: Text("Jahit")),
      const DropdownMenuItem(value: "Dekorasi", child: Text("Dekorasi")),
    ];
    return kategori;
  }


  

  // List<Produk> getProdukHampirHabis() {
  //   return produkList
  //       .where((produk) => produk.stock <= 5 && produk.stock != 0)
  //       .toList();
  // }

  // List<Produk> getProdukHabis() {
  //   return produkList.where((produk) => produk.stock == 0).toList();
  // }
}
