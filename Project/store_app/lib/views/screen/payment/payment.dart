// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/views/screen/payment/payment_done.dart';
import 'package:store_app/views/view_models/payment_cash_view_model.dart';
import 'package:store_app/views/view_models/produk_view_model.dart';
import 'package:store_app/views/view_models/transaksi_view_model.dart';

class ItemMetodePembayaran extends StatelessWidget {
  ItemMetodePembayaran({
    super.key,
    required this.idTransaksi,
    required this.totalHarga,
    required this.metodePembayaran,
    required this.nomorAntrean,
  });

  final String idTransaksi;
  final int totalHarga;
  final String metodePembayaran;
  final int nomorAntrean;

  @override
  Widget build(BuildContext context) {
    var produkProvider = Provider.of<ProdukProvider>(context);
    var transaksiProvider = Provider.of<TransaksiProvider>(context);
    var tunaiProv = Provider.of<TunaiProvider>(context);

    Future<void> konfirmasiPembayaran() async {
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
        backgroundColor: Colors.teal,
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
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 10),
                          child: TextField(
                            controller: tunaiProv.jumlahUangController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9,]')),
                            ],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                tunaiProv.setTotalHarga = totalHarga;
                                final numericValue = int.tryParse(
                                    value.replaceAll(RegExp(r'[^0-9]'), ''));
                                tunaiProv.setJumlahUang = numericValue ?? 0;
                              } else {
                                tunaiProv.setJumlahUang = 0;
                                tunaiProv.setKembalianHarga = -1; //-1 = invalid
                                tunaiProv.kembalianController.clear();
                              }
                              tunaiProv.setKembalian();
                            },
                            decoration: InputDecoration(
                              labelText: 'Jumlah Uang',
                              enabled: tunaiProv.getChipStatus ? false : true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        InputChip(
                          label: const Text('Uang Pas'),
                          selected: tunaiProv.getChipStatus,
                          selectedColor: Colours.lightSalmon,
                          onPressed: () {
                            tunaiProv.setChipStatus = !tunaiProv.getChipStatus;

                            if (tunaiProv.getChipStatus) {
                              tunaiProv.setTotalHarga = totalHarga;
                              tunaiProv.jumlahUangController.text =
                                  formatCurrency.format(totalHarga).toString();
                              tunaiProv.setJumlahUang = totalHarga;
                              tunaiProv.setKembalian();
                            } else {
                              tunaiProv.jumlahUangController.clear();
                              tunaiProv.kembalianController.clear();
                              tunaiProv.setKembalianHarga = -1;
                            }
                          },
                        ),
                        tunaiProv.getChipStatus || tunaiProv.getKembalian >= 0
                            ? SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 25, bottom: 8),
                                      child: Text(
                                        'Kembalian',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      enabled: false,
                                      controller: tunaiProv.kembalianController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                ),
                                                minimumSize:
                                                    const Size(365, 40),
                                                backgroundColor: primaryColor,
                                              ),
                                              onPressed: () async {
                                                tunaiProv.jumlahUangController
                                                    .clear();
                                                tunaiProv.kembalianController
                                                    .clear();
                                                tunaiProv.setKembalianHarga =
                                                    -1;
                                                tunaiProv.setChipStatus = false;
                                                FocusScope.of(context)
                                                    .unfocus();
                                                await transaksiProvider
                                                    .updateTransaksi(
                                                        id: idTransaksi);
                                                await konfirmasiPembayaran();
                                                await produkProvider.getData();
                                              },
                                              child: const Text(
                                                'Konfirmasi Pembayaran',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ),
                  )
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
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    minimumSize: const Size(365, 40),
                                    backgroundColor: primaryColor,
                                  ),
                                  onPressed: () async {
                                    await transaksiProvider.updateTransaksi(
                                        id: idTransaksi);
                                    await konfirmasiPembayaran();
                                    await produkProvider.getData();
                                  },
                                  child: const Text(
                                    'Konfirmasi Pembayaran',
                                    style: TextStyle(
                                        fontFamily: 'Figtree',
                                        fontSize: 16,
                                        color: Colors.white),
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
