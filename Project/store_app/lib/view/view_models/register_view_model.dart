import 'package:flutter/material.dart';

class MyRegisProvider extends ChangeNotifier {
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
}
