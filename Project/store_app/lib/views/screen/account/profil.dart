import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/views/screen/account/login.dart';
import 'package:store_app/views/view_models/account_view_model.dart';
import 'package:store_app/views/view_models/profile_view_model.dart';

class MyProfil extends StatelessWidget {
  const MyProfil({super.key});

  @override
  Widget build(BuildContext context) {
    final profilProvider = Provider.of<ProfilProvider>(context);
    return Consumer<AccountProvider>(
        builder: (BuildContext context, AccountProvider prov, Widget? child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 90.0, vertical: 20),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: primaryColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 20,
                            color: Colors.black.withOpacity(0.1))
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/profile.png'),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 25, left: 20),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nama',
                          style: TextStyle(
                              fontFamily: 'Figtree',
                              fontSize: 16,
                              color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            prov.loginData?.name ?? "",
                            style: const TextStyle(
                              fontFamily: 'Figtree',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'E-mail / No.Hp',
                  style: TextStyle(
                      fontFamily: 'Figtree', fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  '${prov.loginData?.email ?? ""} / 0${prov.loginData?.noHp ?? ""}',
                  style: const TextStyle(
                    fontFamily: 'Figtree',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Jenis Kelamin',
                  style: TextStyle(
                      fontFamily: 'Figtree', fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  prov.loginData?.gender ?? "",
                  style: const TextStyle(
                    fontFamily: 'Figtree',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Ubah Tema",
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                      value: profilProvider.getterswitchvalue,
                      onChanged: (value) {
                        profilProvider.setterswitchValue = value;
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Keluar dari akun Anda?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: const Text(
                                        'Batalkan',
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  TextButton(
                                    onPressed: () {
                                      prov.usernameController.clear();
                                      prov.passwordController.clear();
                                      prov.logout();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const MyLogin()),
                                      );
                                    },
                                    child: Text(
                                      'Keluar',
                                      style: TextStyle(color: primaryColor),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text(
                        "Keluar",
                        style: TextStyle(fontSize: 18),
                      ))),
            ),
          ],
        ),
      );
    });
  }
}
