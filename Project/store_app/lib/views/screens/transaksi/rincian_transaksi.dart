// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:store_app/const/format.dart';

import 'package:store_app/models/transaksi_model.dart';
import 'package:store_app/views/screens/payment/payment.dart';

class RincianTransaksi extends StatefulWidget {
  const RincianTransaksi({
    super.key,
    required this.transaksi,
  });

  final Transaksi transaksi;

  @override
  State<RincianTransaksi> createState() => _RincianTransaksiState();
}

class _RincianTransaksiState extends State<RincianTransaksi> {
  @override
  Widget build(BuildContext context) {
    int totalHargaBelanja = widget.transaksi.qty * widget.transaksi.price;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rincian Transaksi',
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Expanded(
                      flex: 3,
                      child:
                          Text('Nomor Antrian', style: TextStyle(fontSize: 20))),
                  Expanded(
                      flex: 5,
                      child: Text(': ${widget.transaksi.nomorAntrian}',
                          style: const TextStyle(fontSize: 20)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text('Status', style: TextStyle(fontSize: 20))),
                  Expanded(
                      flex: 5,
                      child: Text(
                          ': ${widget.transaksi.inProcess ? 'Dalam Proses' : 'Selesai'}',
                          style: const TextStyle(fontSize: 20)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text('Pembayaran', style: TextStyle(fontSize: 20))),
                  Expanded(
                      flex: 5,
                      child: Text(': ${widget.transaksi.metodePembayaran}',
                          style: const TextStyle(fontSize: 20)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text('Tanggal', style: TextStyle(fontSize: 20))),
                  Expanded(
                      flex: 5,
                      child: Text(': ${formattedDate(widget.transaksi.date)}',
                          style: const TextStyle(fontSize: 20)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text('Waktu', style: TextStyle(fontSize: 20))),
                  Expanded(
                      flex: 5,
                      child: Text(': ${widget.transaksi.time}',
                          style: const TextStyle(fontSize: 20)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text('Qty', style: TextStyle(fontSize: 20))),
                  Expanded(
                      flex: 5,
                      child: Text(': ${widget.transaksi.qty}',
                          style: const TextStyle(fontSize: 20)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text('Harga', style: TextStyle(fontSize: 20))),
                  Expanded(
                      flex: 5,
                      child: Text(
                          ': ${formatCurrency.format(widget.transaksi.price)}',
                          style: const TextStyle(fontSize: 20)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text('Nama Produk', style: TextStyle(fontSize: 20))),
                  Expanded(
                      flex: 5,
                      child: Text(': ${widget.transaksi.namaProduk}',
                          style: const TextStyle(fontSize: 20)))
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 23)),
                    Text(formatCurrency.format(totalHargaBelanja),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600))
                  ]),
            ),
            Row(
              children: [
                Expanded(
                  child: Visibility(
                    visible: widget.transaksi.inProcess,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        minimumSize: const Size(365, 40),
                        backgroundColor: primaryColor,
                      ),
                      child: const Text(
                        'Lanjutkan Transaksi',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ItemMetodePembayaran(
                                    idTransaksi: widget.transaksi.id,
                                    totalHarga: widget.transaksi.qty *
                                        widget.transaksi.price,
                                    metodePembayaran:
                                        widget.transaksi.metodePembayaran,
                                    nomorAntrean:
                                        widget.transaksi.nomorAntrian)));
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
