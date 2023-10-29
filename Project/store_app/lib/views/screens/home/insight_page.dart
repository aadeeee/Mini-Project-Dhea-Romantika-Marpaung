// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/models/produk_model.dart';
import 'package:store_app/services/recomendation_service.dart';
import 'package:store_app/views/view_models/produk_view_model.dart';
import 'package:store_app/views/view_models/recomendation_view_model.dart';
import 'package:store_app/views/view_models/transaksi_view_model.dart';
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
    final aiProvider = Provider.of<RecomendationProvider>(context);

    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;

    List<SalesData> chartData = [];

    for (int i = 1; i <= currentMonth; i++) {
      int sales = i == currentMonth
          ? transaksiProvider.getTotalPenjualan()
          : (Random().nextInt(20) + 10) * 20000;
      chartData.add(SalesData(currentYear, i, sales));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "Insight Harian - ${formattedDate(DateTime.now())}",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500, color: primaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 1),
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
                        Text(
                          'Produk Terjual',
                          style: TextStyle(color: primaryColor),
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
                      border: Border.all(color: primaryColor, width: 1),
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
                        Text(
                          'Transaksi',
                          style: TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ]),
          ),
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
                          fontWeight: FontWeight.bold
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
                    primaryYAxis: NumericAxis(labelFormat: "{value}", numberFormat: formatCurrency),
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
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount: produkProvider.getProdukHampirHabis().length,
              itemBuilder: (BuildContext context, int index) {
                Produk produk = produkProvider.getProdukHampirHabis()[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: primaryColor, width: 2.0),
                              ),
                    child: ListTile(
                      title: Text(produk.namaProduk, style: const TextStyle(fontSize: 18),),
                      subtitle: Text("Stok Tersisa ${produk.stock} buah",style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text(
                        "Produk Rekomendasi",
                        style: TextStyle(
                          fontFamily: 'Figtree',
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: primaryColor, width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            "Daftar produk yang paling banyak dicari saat ini, Direkomendasikan oleh OPENAI:",style: TextStyle(fontSize: 20),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (aiProvider.produkRecomendations == "")
                          TextButton(
                            onPressed: () async {
                              final result =
                                  await RecomendationService.getRecomendation();
                              aiProvider.updateProdukRecomendations(
                                  result.choices[0].text);
                            },
                            child:  Text("Tampilkan", style: TextStyle(color: primaryColor),),
                          )
                        else
                          IconButton(
                            onPressed: () async {
                              final result =
                                  await RecomendationService.getRecomendation();
                              aiProvider.updateProdukRecomendations(
                                  result.choices[0].text);
                            },
                            icon: const Icon(Icons.refresh),
                          )
                      ],
                    ),
                    Text(aiProvider.produkRecomendations, style: const TextStyle(fontSize: 18),),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
