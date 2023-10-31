// ignore_for_file: deprecated_member_use, avoid_print
import 'package:store_app/const/format.dart';
import 'package:store_app/models/transaksi_model.dart';
import 'package:store_app/utils/url.dart';
import 'package:dio/dio.dart';

class TransaksiApiService {
  final Dio _dio = Dio();

  Future<List<Transaksi>> fetchTransaksi() async {
    try {
      final response = await _dio.get(Url.urlTransaksi);
      final List<dynamic> transaksiData = response.data;
      final List<Transaksi> transaksiList = transaksiData.map((data) {
        return Transaksi.fromJson(data)..id = data['_id'];
      }).toList();

      return transaksiList;
    } catch (error) {
      throw Exception('Gagal mengambil data dari API: $error');
    }
  }

  Future<Transaksi> addTransaksi(
      {required int nomorAntrian,
      required String metodePembayaran,
      required int qty,
      required int price,
      required String namaProduk}) async {
    try {
      final Map<String, dynamic> data = {
        'nomorAntrian': nomorAntrian,
        'inProcess': true,
        'metodePembayaran': metodePembayaran,
        'date': DateTime.now().toIso8601String(),
        'time': getCurrentTime().toString(),
        'qty': qty,
        'price': price,
        'namaProduk': namaProduk,
      };
      final response = await _dio.post(Url.urlTransaksi, data: data);

      final addedTransaksi = Transaksi.fromJson(response.data);
      return addedTransaksi;
    } catch (error) {
      throw Exception('Gagal menambahkan transaksi: $error');
    }
  }

  Future<int?> updateTransaksi(String transaksiId) async {
    '${Url.urlTransaksi}/$transaksiId';
    final data = {'inProcess': false};

    try {
      final response =
          await _dio.put('${Url.urlTransaksi}/$transaksiId', data: data);

      return response.statusCode;
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
    return null;
  }

  Future<int?> deleteTransaksi(String id) async {
    try {
      final response = await _dio.delete('${Url.urlTransaksi}/$id');
      return response.statusCode;
    } catch (error) {
      throw Exception('Gagal menghapus transaksi: $error');
    }
  }
}
