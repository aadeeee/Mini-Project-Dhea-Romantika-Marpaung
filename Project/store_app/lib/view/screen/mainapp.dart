import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:store_app/view/screen/home/buttom_navbar.dart';
import 'package:store_app/view/screen/home/home.dart';
import 'package:store_app/view/screen/produk/produk.dart';
import 'package:store_app/view/screen/produk/tambah_produk.dart';
import 'package:store_app/view/screen/transaksi/transaksi.dart';
import 'package:store_app/view/view_models/buttom_navigation_provider.dart';
import 'package:store_app/view/view_models/img_view_model.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List halamanBottomNav = [
    const Home(),
    const MyProduk(),
    const TransaksiListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var bottomnavProvider = Provider.of<BottomNavbarProvider>(context);
    var imgProv = Provider.of<ImgProvider>(context);

    void addProdukAndShowMessage() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const TambahProduk(), fullscreenDialog: true),
      );
    }

    void createNewOrder() {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          confirmBtnColor: Colors.teal[700]!,
          title: 'Tambah Transaksi Baru',
          confirmBtnText: 'Tambah',
          cancelBtnText: 'Tutup',
          showCancelBtn: true,
          onConfirmBtnTap: () {
            bottomnavProvider.setSelectedIdx = 2;

            Navigator.pop(context);
          });
    }
    void viewProduct() {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          confirmBtnColor: Colors.teal[700]!,
          title: 'Lihat Produk?',
          confirmBtnText: 'Lihat',
          cancelBtnText: 'Tutup',
          showCancelBtn: true,
          onConfirmBtnTap: () {
            bottomnavProvider.setSelectedIdx = 1;

            Navigator.pop(context);
          });
    }

    return DefaultTabController(
      length: bottomnavProvider.getSelectedIdx == 0 ? 1 : 1,
      child: Scaffold(
        body: halamanBottomNav[bottomnavProvider.getSelectedIdx],
        bottomNavigationBar: const BottomNavbar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: bottomnavProvider.getSelectedIdx == 1
            ? SpeedDial(
                animatedIcon: AnimatedIcons.menu_close,
                backgroundColor: Colors.teal[700],
                childMargin: const EdgeInsets.all(20),
                children: [
                    SpeedDialChild(
                        label: 'Buat Transaksi Baru',
                        child: const Icon(Icons.add_shopping_cart),
                        onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (_) => TransaksiListScreen()));
                        }),
                    SpeedDialChild(
                        label: 'Tambah Produk',
                        child: const Icon(Icons.pallet),
                        onTap: () {
                          imgProv.setImage = null;
                          addProdukAndShowMessage();
                        }),
                  ])
            : FloatingActionButton(
                onPressed: () {
                  viewProduct();
                },
                tooltip: 'Buat Transaksi Baru',
                backgroundColor: Colors.teal[700],
                child: const Icon(Icons.add_shopping_cart)),
      ),
    );
  }
}
