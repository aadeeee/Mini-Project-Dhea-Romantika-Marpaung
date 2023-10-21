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
  Widget build(BuildContext context) {
    final prov = Provider.of<ProdukProvider>(context);
    return DefaultTabController(
      length: prov.kategoriProduk.length + 1,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: prov.searchController,
            keyboardType: TextInputType.name,
            cursorColor: Colors.teal,
            onChanged: (text) {
              prov.searchProducts(text);
              prov.updateClearButtonVisibility(text);
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: prov.searchController.text.isNotEmpty
                  ? IconButton(
                      icon:const Icon(Icons.clear_all),
                      onPressed: () {
                        prov.updateClearButtonVisibility('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.teal)
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0)
            ),
            
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: prov.getTabs(),
            labelColor: Colors.teal,
            indicatorColor: Colors.teal,
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
      return const Center(
        child: Text("Produk tidak ditemukan"),
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
                      produk.img.contains("https:")
                          ? Image.network(
                              produk.img,
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            )
                          : Image.file(
                              File(produk.img),
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
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
