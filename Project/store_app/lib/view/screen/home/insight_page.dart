// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/models/produk_model.dart';
import 'package:store_app/view/view_models/produk_view_model.dart';
import 'package:store_app/view/view_models/transaksi_view_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  String? dateTime;
  int sales;

  SalesData(int year, int month, this.sales) {
    dateTime = DateFormat.MMM().format(DateTime(year, month));
  }
}

class HomeInsight extends StatefulWidget {
  const HomeInsight({super.key});

  @override
  State<HomeInsight> createState() => _HomeInsightState();
}

class _HomeInsightState extends State<HomeInsight> {
  @override
  Widget build(BuildContext context) {
    final transaksiProvider = Provider.of<TransaksiProvider>(context);
    final produkProvider = Provider.of<ProdukProvider>(context);

    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;

    List<SalesData> chartData = [];

    for (int i = 1; i <= currentMonth; i++) {
      int sales = i == 10
          ? transaksiProvider.getTotalPenjualan()
          : (Random().nextInt(20) + 10) * 20000;
      chartData.add(SalesData(currentYear, i, sales));
    }

    return Column(
      children: [
        Text(
          "Insight Harian - ${formattedDate(DateTime.now())}",
          style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w500),
        ),
        Row(children: [
          Expanded(
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.teal, width: 1), 
                  borderRadius: BorderRadius.circular(5), 
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      transaksiProvider.getTotalProdukTerjual().toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Produk Terjual',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Expanded(
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      formatCurrency
                          .format(transaksiProvider.getTotalPenjualan())
                          .toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Jumlah Transaksi',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ]),
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      "Profit Bulanan",
                      style: TextStyle(
                        fontFamily: 'Figtree',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(labelFormat: "{value}"),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    activationMode: ActivationMode.singleTap,
                  ),
                  series: <ChartSeries>[
                    LineSeries<SalesData, String>(
                        name: 'Penjualan',
                        dataSource: chartData,
                        markerSettings: const MarkerSettings(isVisible: true),
                        xValueMapper: (SalesData sales, _) => sales.dateTime,
                        yValueMapper: (SalesData sales, _) => sales.sales),
                  ]),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  "Produk Hampir Habis",
                  style: TextStyle(
                    fontFamily: 'Figtree',
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 150, // Sesuaikan ketinggian sesuai kebutuhan
          child: ListView.builder(
            itemCount: produkProvider.getProdukHampirHabis().length,
            itemBuilder: (BuildContext context, int index) {
              Produk produk = produkProvider.getProdukHampirHabis()[index];
              return Card(
                child: ListTile(
                  title: Text(produk.namaProduk),
                  subtitle: Text("Stok: ${produk.stock}"),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
