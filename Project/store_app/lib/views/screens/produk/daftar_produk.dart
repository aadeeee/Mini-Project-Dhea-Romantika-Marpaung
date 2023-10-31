import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/models/produk_model.dart';
import 'package:store_app/views/screens/produk/detail_produk.dart';
import 'package:store_app/views/view_models/produk_view_model.dart';

class MyProduk extends StatefulWidget {
  const MyProduk({Key? key}) : super(key: key);

  @override
  State<MyProduk> createState() => _MyProdukState();
}

class _MyProdukState extends State<MyProduk> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProdukProvider>(context, listen: false);
    return DefaultTabController(
      length: prov.kategoriProduk.length + 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: TextField(
              controller: prov.searchController,
              keyboardType: TextInputType.name,
              cursorColor: Colors.white,
              onChanged: (text) {
                prov.searchProducts(text);
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 10.0,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0)),
              style: const TextStyle(color: Colors.white, fontSize: 25)),
          bottom: TabBar(
            isScrollable: true,
            tabs: prov.getTabs(),
            labelStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            labelColor: Colors.white,
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            Consumer<ProdukProvider>(
              builder: (context, prov, child) {
                return buildProductsByCategory(
                    context, prov.produkList, 'Semua Produk');
              },
            ),
            ...prov.kategoriProduk.map((category) {
              return Consumer<ProdukProvider>(
                builder: (context, prov, child) {
                  return buildProductsByCategory(
                      context, prov.produkList, category);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildProductsByCategory(
      BuildContext context, List<Produk> produkList, String category) {
    final searchQuery = Provider.of<ProdukProvider>(context).searchQuery;
    List<Produk> filteredProducts = produkList
        .where((product) =>
            category == 'Semua Produk' || product.kategori == category)
        .toList();
    if (searchQuery.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((product) => product.namaProduk
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    }
    if (filteredProducts.isEmpty) {
      return Center(
        child: Image.asset('assets/images/cart_empty.png',
            width: 350, height: 350),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final produk = filteredProducts[index];
            return Padding(
              padding: const EdgeInsets.all(2),
              child: Card(
                color: const Color.fromARGB(255, 255, 255, 255),
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
                      Flexible(
                        flex: 1,
                        child: produk.img.contains("https:")
                            ? Image.network(
                                produk.img,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                File(produk.img),
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          produk.namaProduk,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          formatCurrency.format(produk.hargaJual),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.teal[500],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
