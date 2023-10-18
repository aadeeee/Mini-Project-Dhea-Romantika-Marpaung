import 'dart:io';

import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/models/produk_model.dart';
import 'package:store_app/view/screen/produk/edit_produk.dart';
import 'package:store_app/view/view_models/produk_view_model.dart';
import 'package:store_app/view/view_models/qty_provider.dart';

class DetailProduk extends StatefulWidget {
  const DetailProduk({super.key, required this.produk});

  final Produk produk;

  @override
  State<DetailProduk> createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  @override
  Widget build(BuildContext context) {
    final qtyProvider = Provider.of<QtyProdukProvider>(context);
    final produkProv = Provider.of<ProdukProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Produk"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            qtyProvider.setQty = 1;
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              Future<void> handleDelete() async {
                await produkProv.deleteProduk(widget.produk.id);
              }

              if (value == 'edit') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            EditProduk(idxProduk: widget.produk.id)));
              } else if (value == 'delete') {
                handleDelete();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  widget.produk.img.contains("https:")
                      ? Image.network(
                          widget.produk.img,
                          height: 200,
                        )
                      : Image.file(
                          File(widget.produk.img),
                          height: 200,
                        ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 25, bottom: 16),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.produk.namaProduk,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 25),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          formatCurrency.format(widget.produk.hargaJual),
                          style:
                              TextStyle(color: Colors.teal[700], fontSize: 20),
                        )),
                  ),
                  widget.produk.deskripsi != ''
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 25, top: 25),
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.produk.deskripsi,
                              )),
                        )
                      : Container(),
                ],
              ),
            ),
            const Divider(indent: 20, endIndent: 25),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 25, top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Stok"),
                      Text(widget.produk.stock.toString()),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 25, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Jumlah"),
                      InputQty(
                        minVal: 1,
                        maxVal: widget.produk.stock,
                        onQtyChanged: (val) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            qtyProvider.setQty = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Subtotal"),
                      Text(formatCurrency.format(
                          widget.produk.hargaJual * qtyProvider.getQty)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
