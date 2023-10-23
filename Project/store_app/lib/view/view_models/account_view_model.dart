import 'package:flutter/material.dart';
import 'package:store_app/models/account_model.dart';
import 'package:store_app/services/account_service.dart';

class AccountProvider extends ChangeNotifier {
  final service = AccountApiService();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
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

  List<Account> produkList = [];

  Future<void> getData() async {
    try {
      final data = await service.fetchUser();
      produkList = data;
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
      throw Exception('Gagal menambahkan produk: $error');
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
}
