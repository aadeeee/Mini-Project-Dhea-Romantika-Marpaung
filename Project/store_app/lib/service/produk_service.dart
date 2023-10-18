// ignore_for_file: deprecated_member_use, avoid_print

import 'package:store_app/models/produk_model.dart';
import 'package:store_app/utils/url.dart';
import 'package:dio/dio.dart';

class ProdukApiService {
  final Dio _dio = Dio();


  Future<List<Produk>> fetchProduk() async {
    try {
      final response = await _dio.get(Url.urlProduk);

      final List<dynamic> produkData = response.data;

      final List<Produk> produkList = produkData.map((data) {
        return Produk.fromJson(data)..id = data['_id'];
      }).toList();

      return produkList;
    } catch (error) {
      throw Exception('Gagal mengambil data dari API: $error');
    }
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
      final Map<String, dynamic> data = {
        'namaProduk': namaProduk,
        'img': img,
        'hargaJual': hargaJual,
        'hargaBeli': hargaBeli,
        'kategori': kategori,
        'deskripsi': deskripsi,
        'stock': stock,
      };

      await _dio.post(Url.urlProduk, data: data);
    } catch (error) {
      throw Exception('Gagal menambahkan produk: $error');
    }
  }

  Future<void> updateProduk(Produk produk) async {
    try {
      final response = await _dio.put(
        '${Url.urlProduk}/${produk.id}',
        queryParameters: {'paramName': 'paramValue'},
        data: produk.toJson(),
      );

      if (response.statusCode == 200) {
        print('Product updated successfully.');
      } else {
        print('Failed to update product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating product: $error');
      throw Exception('Gagal memperbarui produk: $error');
    }
  }

  Future<void> deleteProduk(String id) async {
    try {
      final response = await _dio.delete('${Url.urlProduk}/$id');
      if (response.statusCode == 200) {
        print('Product deleted successfully.');
      } else {
        print('Failed to delete product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting product: $error');
      throw Exception('Gagal menghapus produk: $error');
    }
  }
}
