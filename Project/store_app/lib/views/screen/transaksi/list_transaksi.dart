import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/format.dart';

import 'package:store_app/models/transaksi_model.dart';
import 'package:store_app/views/screen/transaksi/rincian_transaksi.dart';
import 'package:store_app/views/view_models/transaksi_view_model.dart';

class TransaksiCard extends StatefulWidget {
  final Transaksi transaksi;

  const TransaksiCard({super.key, required this.transaksi});

  @override
  State<TransaksiCard> createState() => _TransaksiCardState();
}

class _TransaksiCardState extends State<TransaksiCard> {
  @override
  Widget build(BuildContext context) {
    final transaksiProvider = Provider.of<TransaksiProvider>(context);
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Colors.teal[700]!,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text('Antrian: ${widget.transaksi.nomorAntrian}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.transaksi.inProcess) const Text('Diproses'),
                if (!widget.transaksi.inProcess)
                  Text(widget.transaksi.metodePembayaran),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RincianTransaksi(
                                    transaksi: widget.transaksi,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      backgroundColor: primaryColor,
                    ),
                    child: const Text('Rincian'),
                  ),
                ),
                if (widget.transaksi.inProcess)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await transaksiProvider.deleteTransaksi(widget.transaksi.id);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        backgroundColor: primaryColor,
                      ),
                      child: const Text('Hapus'),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
