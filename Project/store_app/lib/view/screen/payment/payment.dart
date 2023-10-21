// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/view/screen/payment/payment_cash.dart';
import 'package:store_app/view/screen/payment/payment_done.dart';
import 'package:store_app/view/view_models/payment_cash_view_model.dart';
import 'package:store_app/view/view_models/produk_view_model.dart';
import 'package:store_app/view/view_models/transaksi_view_model.dart';

class ItemMetodePembayaran extends StatelessWidget {
  ItemMetodePembayaran(
      {super.key,
      required this.idTransaksi,
      required this.totalHarga,
      required this.metodePembayaran,
      required this.nomorAntrean});

  final String idTransaksi;
  final int totalHarga;
  final String metodePembayaran;
  final int nomorAntrean;

  @override
  Widget build(BuildContext context) {
    var produkProvider = Provider.of<ProdukProvider>(context);
    var transaksiProvider = Provider.of<TransaksiProvider>(context);
    var tunaiProv = Provider.of<TunaiProvider>(context);

    Future<void> konfirmasiPembayaran() async{
      await transaksiProvider.transaksiSelesai(
          idTransaksi, produkProvider.produkList);

      Navigator.push(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => PaymentDone(nomorAntrean: nomorAntrean)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran $metodePembayaran'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              tunaiProv.jumlahUangController.clear();
              tunaiProv.kembalianController.clear();
              tunaiProv.setKembalianHarga = -1;
              tunaiProv.setChipStatus = false;
              FocusScope.of(context).unfocus();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                'Total Belanjaan',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Text(formatCurrency.format(totalHarga),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30, color: Colors.green)),
            ),
            metodePembayaran == 'Tunai'
                ? PembayaranTunai(
                    totalHarga: totalHarga,
                    konfirmasiPembayaran: konfirmasiPembayaran)
                : Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text(
                          'Silahkan Scan Kode QR di bawah ini',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      QrImageView(
                        data:
                            'Pembayaran $metodePembayaran sebesar ${formatCurrency.format(totalHarga)}',
                        version: QrVersions.auto,
                        size: 250,
                        embeddedImageStyle:
                            const QrEmbeddedImageStyle(size: Size(50, 50)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal[700]),
                                  onPressed: () async{
                                    print(idTransaksi);
                                    await transaksiProvider.updateTransaksi(id: idTransaksi);
                                    await konfirmasiPembayaran();
                                  },
                                  child: const Text(
                                    'Konfirmasi Pembayaran',
                                    style: TextStyle(
                                        fontFamily: 'Figtree', fontSize: 16),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
