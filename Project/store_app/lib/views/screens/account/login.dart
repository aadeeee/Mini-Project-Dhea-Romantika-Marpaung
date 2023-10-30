// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/views/screens/account/register.dart';
import 'package:store_app/views/screens/mainapp.dart';
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
                            color: primaryColor),
                      )),
                  Positioned(
                      top: 100,
                      right: -50,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: primaryColor),
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
                                        } else if (!prov.loggedIn) {
                                          QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.error,
                                              text:
                                                  "Data yang Anda masukkan tidak sesuai, \ncek kembali data Anda");
                                        }
                                      } catch (error) {
                                        print(error);
                                      }
                                      prov.usernameController.clear();
                                      prov.passwordController.clear();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
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
                                      Text("Belum Punya Akun ?",
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 16)),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const MyRegister()));
                                          },
                                          child: Text(
                                            "Daftar disini",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: primaryColor,
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
