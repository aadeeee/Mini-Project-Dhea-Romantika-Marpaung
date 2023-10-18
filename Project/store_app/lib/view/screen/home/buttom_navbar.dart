import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/view/screen/home/home.dart';
import 'package:store_app/view/screen/produk/produk.dart';
import 'package:store_app/view/screen/transaksi/transaksi.dart';
import 'package:store_app/view/view_models/buttom_navigation_provider.dart';

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
          icon: Icon(Icons.store, color: Colors.transparent),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Transaksi',
        ),
      ],
      currentIndex: bottomnavProvider.getSelectedIdx,
      selectedItemColor: Colours.lightSalmon,
      onTap: (value) {
        bottomnavProvider.setSelectedIdx = value;
      },
      type: BottomNavigationBarType.fixed,
    );
  }
}
