
import 'package:flutter/material.dart';
import 'package:store_app/models/transaksi_model.dart';
import 'package:store_app/views/screens/transaksi/list_transaksi.dart';


class TransaksiTab extends StatelessWidget {
  final List<Transaksi> transaksiList;
  final bool inProcess;

  const TransaksiTab(this.transaksiList, {super.key, required this.inProcess});

  @override
  Widget build(BuildContext context) {
    final filteredTransaksiList =
        transaksiList.where((transaksi) => transaksi.inProcess == inProcess).toList();

    return ListView.builder(
      itemCount: filteredTransaksiList.length,
      itemBuilder: (context, index) {
        final transaksi = filteredTransaksiList[index];
        return TransaksiCard(transaksi: transaksi);
      },
    );
  }
}