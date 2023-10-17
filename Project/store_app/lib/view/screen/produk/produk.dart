import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/models/produk_model.dart';
import 'package:store_app/view/screen/produk/detail_produk.dart';
import 'package:store_app/view/view_models/produk_view_model.dart';

class MyProduk extends StatefulWidget {
  const MyProduk({Key? key}) : super(key: key);

  @override
  State<MyProduk> createState() => _MyProdukState();
}

class _MyProdukState extends State<MyProduk> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProdukProvider>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProdukProvider>(context, listen: false);
    return DefaultTabController(
      length: prov.kategoriProduk.length + 1,
      child: Scaffold(
        appBar: AppBar(
          
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              const Tab(
                text: 'Semua Produk',
              ),
              ...prov.kategoriProduk
                  .map((category) => Tab(
                        text: category,
                      ))
                  .toList(),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildProductsByCategory(context, prov.produkList, 'Semua Produk'),
            ...prov.kategoriProduk.map((category) {
              return buildProductsByCategory(
                  context, prov.produkList, category);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildProductsByCategory(
      BuildContext context, List<Produk> produkList, String category) {
    List<Produk> filteredProducts = produkList
        .where((product) =>
            category == 'Semua Produk' || product.kategori == category)
        .toList();
    if (filteredProducts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final produk = filteredProducts[index];
          print(produk.namaProduk);
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailProduk(produk: produk),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  produk.img.contains("https:")
                      ? Image.network(
                          produk.img,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          File(produk.img),
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      produk.namaProduk,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      formatCurrency.format(produk.hargaJual),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.teal[500],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'Stok: ${produk.stock} item',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
