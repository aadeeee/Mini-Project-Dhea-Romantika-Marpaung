import 'package:flutter/material.dart';
import 'package:store_app/models/transaksi_model.dart';

class TransaksiCard extends StatefulWidget {
  final Transaksi transaksi;

  const TransaksiCard({super.key, required this.transaksi});

  @override
  State<TransaksiCard> createState() => _TransaksiCardState();
}

class _TransaksiCardState extends State<TransaksiCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text('Nomor Antrian: ${widget.transaksi.nomorAntrian}'),
          ),
          ListTile(
            title: Text('Status: ${widget.transaksi.inProcess ? 'Sedang Diproses' : 'Selesai'}'),
          ),
          ListTile(
            title: Text('Metode Pembayaran: ${widget.transaksi.metodePembayaran}'),
          ),
          ListTile(
            title: Text('Tanggal: ${widget.transaksi.date.toString()}'),
          ),
          ListTile(
            title: Text('Waktu: ${widget.transaksi.time}'),
          ),
          ExpansionTile(
            title: const Text('Daftar Produk'),
            children: widget.transaksi.listProduk.entries
                .map((entry) =>
                    ListTile(title: Text('${entry.key}: ${entry.value}')))
                .toList(),
          ),
          ListTile(
            title: Text('Produk Akhir: ${widget.transaksi.listProdukAkhir.join(', ')}'),
          ),
        ],
      ),
    );
  }
}
