import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/view/screen/account/login.dart';
import 'package:store_app/view/screen/mainapp.dart';
import 'package:store_app/view/view_models/buttom_navigation_view_model.dart';
import 'package:store_app/view/view_models/form_produk_view_model.dart';
import 'package:store_app/view/view_models/img_view_model.dart';
import 'package:store_app/view/view_models/payment_cash_view_model.dart';
import 'package:store_app/view/view_models/produk_view_model.dart';
import 'package:store_app/view/view_models/profile_view_model.dart';
import 'package:store_app/view/view_models/qty_provider_view_model.dart';
import 'package:store_app/view/view_models/account_view_model.dart';
import 'package:store_app/view/view_models/transaksi_view_model.dart';

void main() async {
  final transaksiProvider = TransaksiProvider();
  await transaksiProvider.getData();

  final produkProvider = ProdukProvider();
  await produkProvider.getData();

  final accountProvider = AccountProvider();
  await accountProvider.getData();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider.value(value: produkProvider),
      ChangeNotifierProvider(create: (_) => QtyProdukProvider()),
      ChangeNotifierProvider(create: (_) => ImgProvider()),
      ChangeNotifierProvider(create: (_) => ProdukFormProvider()),
      ChangeNotifierProvider.value(value: transaksiProvider),
      ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
      ChangeNotifierProvider(create: (_) => TunaiProvider()),
      ChangeNotifierProvider(create: (_) => ProfilProvider()),
      ChangeNotifierProvider.value(value: accountProvider),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final profilProvider = Provider.of<ProfilProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: profilProvider.getTheme(),
      home: Consumer<AccountProvider>(
        builder: (context, prov, child) {
          if (prov.loggedIn == true) {
            return const MainApp();
          } else {
            return const MyLogin();
          }
        },
      ),
    );
  }
}
