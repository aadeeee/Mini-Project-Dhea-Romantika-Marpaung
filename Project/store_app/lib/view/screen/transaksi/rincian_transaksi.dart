// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:store_app/const/format.dart';

import 'package:store_app/models/transaksi_model.dart';
import 'package:store_app/view/screen/payment/payment.dart';

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
      appBar: AppBar(title: const Text('Rincian Transaksi'), backgroundColor: Colors.teal,),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Nomor Antrian')),
                Expanded(
                    flex: 5, child: Text(': ${widget.transaksi.nomorAntrian}'))
              ],
            ),
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Status')),
                Expanded(
                    flex: 5,
                    child: Text(
                        ': ${widget.transaksi.inProcess ? 'Dalam Proses' : 'Selesai'}'))
              ],
            ),
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Metode Pembayaran')),
                Expanded(
                    flex: 5,
                    child: Text(': ${widget.transaksi.metodePembayaran}'))
              ],
            ),
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Tanggal')),
                Expanded(
                    flex: 5,
                    child: Text(': ${formattedDate(widget.transaksi.date)}'))
              ],
            ),
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Waktu')),
                Expanded(flex: 5, child: Text(': ${widget.transaksi.time}'))
              ],
            ),
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Qty')),
                Expanded(flex: 5, child: Text(': ${widget.transaksi.qty}'))
              ],
            ),
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Harga')),
                Expanded(
                    flex: 5,
                    child: Text(
                        ': ${formatCurrency.format(widget.transaksi.price)}'))
              ],
            ),
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Nama Produk')),
                Expanded(
                    flex: 5, child: Text(': ${widget.transaksi.namaProduk}'))
              ],
            ),
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Total')),
                Expanded(
                    flex: 5,
                    child:
                        Text(': ${formatCurrency.format(totalHargaBelanja)}'))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 18)),
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
                        backgroundColor: Colors.teal,
                      ),
                      child: Text(
                        'Lanjutkan Transaksi',
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.fontSize,
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
