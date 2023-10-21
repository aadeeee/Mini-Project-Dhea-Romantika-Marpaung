import 'package:flutter/material.dart';
import 'package:store_app/models/transaksi_model.dart';
import 'package:store_app/view/screen/transaksi/rincian_transaksi.dart';

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
            subtitle: Text(widget.transaksi.inProcess ? 'Diproses' : 'Selesai'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => RincianTransaksi(transaksi: widget.transaksi)));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), 
                        ),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                          color: Colors.orangeAccent, 
                          width: 1.0, 
                        ),
                      ),
                    ),
                    child: const Text('Rincian'),
                  ),
                ),

     
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), 
                        ),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                          color: Colors.orangeAccent, 
                          width: 1.0, 
                        ),
                      ),
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
