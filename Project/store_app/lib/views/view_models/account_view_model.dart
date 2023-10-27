// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/models/account_model.dart';
import 'package:store_app/services/account_service.dart';

class AccountProvider extends ChangeNotifier {
  final service = AccountApiService();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController nohandphoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  TextEditingController get getUserNameController => usernameController;
  TextEditingController get getNameController => nameController;
  TextEditingController get getNoHandphoneController => nohandphoneController;
  TextEditingController get getEmailController => emailController;
  TextEditingController get getPasswordController => passwordController;
  TextEditingController get getGenderController => genderController;

  GlobalKey<FormState> get globalKey => _globalKey;

  bool isUserNameEmpty = false;
  bool isNameEmpty = false;
  bool isNoHandphoneEmpty = false;
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;
  bool isGenderEmpty = false;

  set userNameEmpty(value) {
    isUserNameEmpty = value;
    notifyListeners();
  }

  set nameEmpty(value) {
    isNameEmpty = value;
    notifyListeners();
  }

  set noHandPhoneEmpty(value) {
    isNoHandphoneEmpty = value;
    notifyListeners();
  }

  set emailEmpty(value) {
    isEmailEmpty = value;
    notifyListeners();
  }

  set passwordEmpty(value) {
    isPasswordEmpty = value;
    notifyListeners();
  }

  set repasswordEmpty(value) {
    isGenderEmpty = value;
    notifyListeners();
  }

  bool get getUserNameIsEmpty => isUserNameEmpty;
  bool get getNameIsEmpty => isNameEmpty;
  bool get getNoHandphoneIsEmpty => isNoHandphoneEmpty;
  bool get getEmailIsEmpty => isEmailEmpty;
  bool get getUPasswordIsEmpty => isPasswordEmpty;
  bool get getRePasswordIsEmpty => isGenderEmpty;

  bool obsecureTextPassword = true;
  bool obsecureTextRePassword = true;

  get getObsecureTextPasswword => obsecureTextPassword;

  set setObsecureTextPassword(value) {
    obsecureTextPassword = value;
    notifyListeners();
  }

  get getObsecureTextRePasswword => obsecureTextRePassword;

  set setObsecureTextRePassword(value) {
    obsecureTextRePassword = value;
    notifyListeners();
  }

  List<Account> userList = [];

  Future<void> getData() async {
    try {
      final data = await service.fetchUser();
      userList = data;
      notifyListeners();
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
      await service.addUser(
        name: name,
        username: username,
        gender: gender,
        email: email,
        noHp: noHp,
        password: password,
      );
      await getData();
    } catch (error) {
      throw Exception('Gagal menambahkan user: $error');
    }
  }

  //validasi nama
  String? _errorMessageName;

  String? get errorMessageName => _errorMessageName;
  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      _errorMessageName = 'Name is required';
    } else {
      _errorMessageName = null;
    }

    notifyListeners();

    return _errorMessageName;
  }

  //validasi email
  String? _errorMessageEmail;

  String? get errorMessageEmail => _errorMessageEmail;
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      _errorMessageEmail = 'Email is required';
    } else if (!email.contains('@')) {
      _errorMessageEmail = 'Invalid Email';
    } else {
      _errorMessageEmail = null;
    }

    notifyListeners();

    return _errorMessageEmail;
  }

  //validasiPhone
  String? _errorMessagePhone;

  String? get errorMessagePhone => _errorMessagePhone;

  String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      _errorMessagePhone = 'Phone Number is required';
    } else if (!RegExp(r'^0[0-9]{7,14}$').hasMatch(phoneNumber)) {
      _errorMessagePhone =
          'Phone numbers must start with 0 and have 8-15 digits';
    } else {
      _errorMessagePhone = null;
    }

    notifyListeners();

    return _errorMessagePhone;
  }

  String? _errorMessagePassword;

  String? get errorMessagePassword => _errorMessagePassword;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      _errorMessagePassword = 'Password is required';
    } else if (value.length < 4 || value.length > 8) {
      _errorMessagePassword = 'Password must be between 4 and 8 characters';
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])').hasMatch(value)) {
      _errorMessagePassword =
          'Password must contain at least one letter and one number';
    } else {
      _errorMessagePassword = null;
    }
    notifyListeners();
    return _errorMessagePassword;
  }

  bool loggedIn = false;
  String loggedInUsername = '';
  Login? loginData;

  Future<Login> login(String username, String password) async {
    try {
      final success = await loginUser(username: username, password: password);
      setLoginData(success);
      await saveLoginData(username);
      return success;
    } catch (error) {
      throw Exception('Gagal login: $error');
    }
  }

  Future<void> saveLoginData(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', true);
    prefs.setString('loggedInUsername', username);
    if (loginData != null) {
      prefs.setString('loginData', json.encode(loginData!.toJson()));
    }
    loggedIn = true;
    loggedInUsername = username;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool('loggedIn') ?? false;
    if (loggedIn) {
      loggedInUsername = prefs.getString('loggedInUsername') ?? '';
    }
    if (loginData == null) {
      await getSavedDataLogin();
    }
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);
    prefs.remove('loggedInUsername');
    prefs.remove('loginData');
    loginData = null;
    loggedIn = false;
    loggedInUsername = '';
    notifyListeners();
  }

  Future<Login> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final success = await service.loginUser(
        username: username,
        password: password,
      );
      return success;
    } catch (error) {
      throw Exception('Gagal login: $error');
    }
  }

  void setLoginData(Login data) async {
    loginData = data;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginData', json.encode(data.toJson()));
  }

  Future<void> getSavedDataLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('loginData');
    if (jsonString != null) {
      final jsonData = json.decode(jsonString);
      final loginDataa = Login.fromJson(jsonData);
      loginData = loginDataa;
      notifyListeners();
    }
  }
}
