import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:store_app/view/screen/account/login.dart';
import 'package:store_app/view/screen/mainapp.dart';
import 'package:store_app/view/view_models/register_view_model.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyRegisProvider>(context);
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
                    color: Colors.teal,
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
                    color: Colors.teal,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
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
                                          color: Colors.black)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  fillColor: Colors.black,
                                  hintText: "Nama Lengkap",
                                  errorText: prov.isNameEmpty == true
                                      ? "wajib diisi"
                                      : null),
                            ),
                          ),
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
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
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
                              controller: prov.getGenderController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.mail,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  fillColor: Colors.black,
                                  hintText: "Jenis Kelamin",
                                  errorText: prov.isGenderEmpty == true
                                      ? "wajib diisi"
                                      : null),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
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
                                          color: Colors.black)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  fillColor: Colors.black,
                                  hintText: "No.Telepon",
                                  errorText: prov.isNoHandphoneEmpty == true
                                      ? "wajib diisi"
                                      : null),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
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
                                          color: Colors.black)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  fillColor: Colors.black,
                                  hintText: "Email",
                                  errorText: prov.isEmailEmpty == true
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
                                              !prov.getObsecureTextPasswword;
                                        });
                                      }),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
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
                              onPressed: () {
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
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const MyLogin()));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  minimumSize: const Size.fromHeight(60),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: const Text(
                                "DAFTAR",
                                style: TextStyle(color: Colors.white10)
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sudah Punya Akun ?",
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyLogin()));
                                  },
                                  child: const Text(
                                    "Masuk disini",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
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
  }
}
