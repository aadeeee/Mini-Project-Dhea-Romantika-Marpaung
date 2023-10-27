// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/views/screen/account/register.dart';
import 'package:store_app/views/screen/mainapp.dart';
import 'package:store_app/views/view_models/account_view_model.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  void initState() {
    super.initState();
    Provider.of<AccountProvider>(context, listen: false).checkLoginStatus();
    Provider.of<AccountProvider>(context, listen: false).loggedInUsername;
  }

  @override
  Widget build(BuildContext context) {
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
                            color: Colors.teal),
                      )),
                  Positioned(
                      top: 100,
                      right: -50,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.teal),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: SizedBox(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: prov.usernameController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.account_circle,
                                          color: Colors.black,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        fillColor: Colors.black,
                                        hintText: "Nama Pengguna",
                                        errorText: prov.isUserNameEmpty == true
                                            ? "wajib diisi"
                                            : null),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
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
                                                    !prov
                                                        .getObsecureTextPasswword;
                                              });
                                            }),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        fillColor: Colors.black,
                                        hintText: "Kata Sandi",
                                        errorText: prov.isPasswordEmpty == true
                                            ? "wajib diisi"
                                            : null),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        await prov.login(
                                          prov.usernameController.text,
                                          prov.passwordController.text,
                                        );
                                        if (prov.loggedIn) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const MainApp()),
                                          );
                                        } else if (prov.loggedIn == false) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: const Text(
                                                  'Nama dan kata sandi Anda tidak sesuai atau belum terdaftar, cek kembali data Anda',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      } catch (error) {
                                        print(error);
                                      }
                                      prov.usernameController.clear();
                                      prov.passwordController.clear();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        minimumSize: const Size.fromHeight(60),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    child: const Text("MASUK",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Belum Punya Akun ?",
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 16)),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const MyRegister()));
                                          },
                                          child: const Text(
                                            "Daftar disini",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.teal,
                                                fontSize: 16),
                                          )),
                                    ],
                                  ),
                                )
                              ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}