import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/view/screen/account/profil.dart';
import 'package:store_app/view/screen/home/home.dart';
import 'package:store_app/view/screen/produk/daftar_produk.dart';
import 'package:store_app/view/screen/transaksi/daftar_transaksi.dart';
import 'package:store_app/view/view_models/buttom_navigation_view_model.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  List halamanBottomNav = [
    const Home(),
    const MyProduk(),
    const TransaksiListScreen(),
    const MyProfil(),
  ];

  @override
  Widget build(BuildContext context) {
    var bottomnavProvider = Provider.of<BottomNavbarProvider>(context);

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Produk',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Transaksi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
      currentIndex: bottomnavProvider.getSelectedIdx,
      unselectedItemColor: Colors.teal[200],
      selectedItemColor: Colors.teal[700],
      showUnselectedLabels: false,
      onTap: (value) {
        bottomnavProvider.setSelectedIdx = value;
      },
      type: BottomNavigationBarType.fixed,
    );
  }
}
