import 'package:colours/colours.dart';
import 'package:flutter/material.dart';

class TabNavigasiTransaksi extends StatelessWidget {
  const TabNavigasiTransaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
      labelStyle: const TextStyle(fontSize: 15),
      tabs: const [
        Tab(text: "Dalam Proses"),
        Tab(text: "Selesai"),
      ],
      indicatorColor: Colours.lightSalmon,
      labelColor: Colours.lightSalmon[500],
    );
  }
}
