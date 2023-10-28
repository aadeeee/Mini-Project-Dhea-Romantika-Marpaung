// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/views/screen/account/login.dart';
import 'package:store_app/views/view_models/account_view_model.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  @override
  Widget build(BuildContext context) {
    final accProv = Provider.of<AccountProvider>(context);
    return Consumer<AccountProvider>(
      builder: (BuildContext context, AccountProvider prov, Widget? child) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            body: Stack(
              children: [
                Positioned(
                  top: -20,
                  left: -50,
                  child: Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: primaryColor,
                      )),
                ),
                Positioned(
                    top: 100,
                    right: -50,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: primaryColor,
                      ),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Image.asset(
                            'assets/images/my_user.png',
                            height: 130,
                            width: 130,
                          ),
                        ),
                        Form(
                          key: prov.globalKey,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: SizedBox(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    key: const Key('name'),
                                    controller: prov.nameController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.account_circle,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      fillColor: Colors.black,
                                      hintText: "Nama Lengkap",
                                    ),
                                    validator: (value) =>
                                        prov.validateName(value),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    key: const Key('username'),
                                    controller: prov.usernameController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.account_circle,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      fillColor: Colors.black,
                                      hintText: "Nama Pengguna",
                                    ),
                                    validator: (value) =>
                                        prov.validateName(value),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    key: const Key('gender'),
                                    controller: prov.getGenderController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      fillColor: Colors.black,
                                      hintText: "Jenis Kelamin",
                                    ),
                                    validator: (value) =>
                                        prov.validateName(value),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: prov.nohandphoneController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.phone,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      fillColor: Colors.black,
                                      hintText: "No.Telepon",
                                    ),
                                    validator: (value) =>
                                        prov.validatePhoneNumber(value),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    key: const Key('email'),
                                    controller: prov.emailController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.mail,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      fillColor: Colors.black,
                                      hintText: "Email",
                                    ),
                                    validator: (value) =>
                                        prov.validateEmail(value),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    key: const Key('password'),
                                    obscureText: prov.getObsecureTextPasswword,
                                    controller: prov.passwordController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          prov.getObsecureTextPasswword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            prov.setObsecureTextPassword =
                                                !prov.getObsecureTextPasswword;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      fillColor: Colors.black,
                                      hintText: "Kata Sandi",
                                    ),
                                    validator: (value) =>
                                        prov.validatePassword(value),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final nomorHpText =
                                          prov.nohandphoneController.text;
                                      final nomorHp =
                                          int.tryParse(nomorHpText) ?? 0;

                                      if (prov.globalKey.currentState!
                                          .validate()) {
                                        await accProv.addUser(
                                            name: prov.nameController.text,
                                            username:
                                                prov.usernameController.text,
                                            gender: prov.genderController.text,
                                            email: prov.emailController.text,
                                            noHp: nomorHp,
                                            password:
                                                prov.passwordController.text);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const MyLogin()));
                                        prov.nameController.clear();

                                        prov.usernameController.clear();
                                        prov.genderController.clear();
                                        prov.emailController.clear();
                                        prov.nohandphoneController.clear();

                                        prov.passwordController.clear();
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: const Text(
                                                'Data yang Anda masukkan tidak sesuai, cek kembali data Anda.',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'OK',
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        minimumSize: const Size.fromHeight(60),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    child: const Text("DAFTAR",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Sudah Punya Akun ?",
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const MyLogin()));
                                        },
                                        child: Text(
                                          "Masuk disini",
                                          style: TextStyle(color: primaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
