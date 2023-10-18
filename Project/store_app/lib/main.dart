import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/view/screen/mainapp.dart';
import 'package:store_app/view/view_models/buttom_navigation_provider.dart';
import 'package:store_app/view/view_models/form_produk.dart';
import 'package:store_app/view/view_models/img_view_model.dart';
import 'package:store_app/view/view_models/produk_view_model.dart';
import 'package:store_app/view/view_models/qty_provider.dart';
import 'package:store_app/view/view_models/transaksi_view_model.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ProdukProvider()),
      ChangeNotifierProvider(create: (_) => QtyProdukProvider()),
      ChangeNotifierProvider(create: (_) => ImgProvider()),
      ChangeNotifierProvider(create: (_) => ProdukFormProvider()),
      ChangeNotifierProvider(create: (_) => TransaksiProvider()),
      ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainApp(),
    );
  }
}

