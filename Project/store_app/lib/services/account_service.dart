// ignore_for_file: deprecated_member_use, avoid_print

import 'package:store_app/models/account_model.dart';
import 'package:store_app/utils/url.dart';
import 'package:dio/dio.dart';

class AccountApiService {
  final Dio _dio = Dio();

  Future<List<Account>> fetchUser() async {
    try {
      final response = await _dio.get(Url.urlRegister);

      final List<dynamic> accountData = response.data;

      final List<Account> accountList = accountData.map((data) {
        return Account.fromJson(data)..id = data['_id'];
      }).toList();
      print(accountList);
      return accountList;
    } catch (error) {
      throw Exception('Gagal mengambil data dari API: $error');
    }
  }

  Future<void> addUser({
    required String name,
    required String username,
    required String gender,
    required String email,
    required int noHp,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "name": name,
        "username": username,
        "gender": gender,
        "email": email,
        "noHp": noHp,
        "password": password,
      };

      await _dio.post(Url.urlRegister, data: data);
    } catch (error) {
      throw Exception('Gagal menambahkan user: $error');
    }
  }

  
  // }
  Future<Login> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "username": username,
        "password": password,
      };

      final response = await _dio.post(Url.urllogin, data: data);

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = response.data;
        final loginData = Login.fromJson(userData);
        print(loginData.gender);
        return loginData;
      
      } else {
        throw Exception('Gagal login: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Gagal login: $error');
    }
  }
}
