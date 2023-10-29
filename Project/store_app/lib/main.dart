import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/views/screens/account/login.dart';
import 'package:store_app/views/screens/mainapp.dart';
import 'package:store_app/views/view_models/buttom_navigation_view_model.dart';
import 'package:store_app/views/view_models/form_produk_view_model.dart';
import 'package:store_app/views/view_models/img_view_model.dart';
import 'package:store_app/views/view_models/payment_cash_view_model.dart';
import 'package:store_app/views/view_models/produk_view_model.dart';
import 'package:store_app/views/view_models/profile_view_model.dart';
import 'package:store_app/views/view_models/qty_provider_view_model.dart';
import 'package:store_app/views/view_models/account_view_model.dart';
import 'package:store_app/views/view_models/recomendation_view_model.dart';
import 'package:store_app/views/view_models/transaksi_view_model.dart';

void main() async {
  final transaksiProvider = TransaksiProvider();
  await transaksiProvider.getData();

  final produkProvider = ProdukProvider();
  await produkProvider.getData();

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
      ChangeNotifierProvider(create: (_) => AccountProvider()),
      ChangeNotifierProvider(create: (_) => RecomendationProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final profilProvider = Provider.of<ProfilProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: profilProvider.getTheme(),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AccountProvider>(context, listen: false).checkLoginStatus();
    Future.delayed(const Duration(seconds: 3), () {
      final accountProvider =
          Provider.of<AccountProvider>(context, listen: false);
      if (accountProvider.loggedIn == true) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainApp()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyLogin()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.jpg',
              height: 150,
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
