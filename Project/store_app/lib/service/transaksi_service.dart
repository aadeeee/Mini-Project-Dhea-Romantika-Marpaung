// ignore_for_file: deprecated_member_use, avoid_print
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
        
      return Transaksi.fromJson(data)
        ..id = data['_id']; 
      
    }).toList();
    
  
      return transaksiList;
    } catch (error) {
      throw Exception('Gagal mengambil data dari API: $error');
    }
  }

  Future<Transaksi> addTransaksi(Transaksi transaksi) async {
    try {
      final response =
          await _dio.post(Url.urlTransaksi, data: transaksi.toJson());

      final addedTransaksi = Transaksi.fromJson(response.data);
      return addedTransaksi;
    } catch (error) {
      throw Exception('Gagal menambahkan transaksi: $error');
    }
  }

  Future<Transaksi> updateTransaksi(Transaksi transaksi) async {
    try {
      final response = await _dio.put('${Url.urlTransaksi}/${transaksi.id}',
          data: transaksi.toJson());

      final updatedTransaksi = Transaksi.fromJson(response.data);
      return updatedTransaksi;
    } catch (error) {
      throw Exception('Gagal memperbarui transaksi: $error');
    }
  }

  Future<void> deleteTransaksi(String id) async {
    try {
      await _dio.delete('${Url.urlTransaksi}/$id');
    } catch (error) {
      throw Exception('Gagal menghapus transaksi: $error');
    }
  }
}
