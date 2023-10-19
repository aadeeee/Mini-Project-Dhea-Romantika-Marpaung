import 'package:flutter/material.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/models/transaksi_model.dart';

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
    int totalHargaBelanja = widget.transaksi.qty! * widget.transaksi.price!;

    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Transaksi')),
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
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      side: BorderSide(
                        color: Colors.teal[700]!,
                        width: 2.0,
                      ),
                      disabledForegroundColor:
                          Colors.teal[700]!.withOpacity(0.38),
                      disabledBackgroundColor:
                          Colors.teal[700]!.withOpacity(0.12)),
                  child: Text(
                    'Pilih metode pembayaran',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize,
                    ),
                  ),
                  onPressed: () {},
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
