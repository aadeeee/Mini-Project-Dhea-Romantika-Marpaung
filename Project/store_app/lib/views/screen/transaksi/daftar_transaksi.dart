import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/views/screen/transaksi/tab_transaksi.dart';
import 'package:store_app/views/view_models/transaksi_view_model.dart';

class TransaksiListScreen extends StatefulWidget {
  const TransaksiListScreen({super.key});

  @override
  State<TransaksiListScreen> createState() => _TransaksiListScreenState();
}

class _TransaksiListScreenState extends State<TransaksiListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransaksiProvider>(context, listen: false).getData();
  }
  @override
  Widget build(BuildContext context) {
    final transaksiProvider = Provider.of<TransaksiProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Daftar Transaksi'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sedang Diproses'),
              Tab(text: 'Selesai'),
              
            ],
            labelColor: Colors.white,
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            TransaksiTab(transaksiProvider.transaksiList, inProcess: true),
            TransaksiTab(transaksiProvider.transaksiList, inProcess: false),

          ],
        ),
      ),
    );
  }
}