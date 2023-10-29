// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/models/produk_model.dart';
import 'package:store_app/views/screens/produk/edit_produk.dart';
import 'package:store_app/views/screens/transaksi/daftar_transaksi.dart';
import 'package:store_app/views/view_models/produk_view_model.dart';
import 'package:store_app/views/view_models/qty_provider_view_model.dart';
import 'package:store_app/views/view_models/transaksi_view_model.dart';

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
    final transaksiProv = Provider.of<TransaksiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Produk"),
        backgroundColor: primaryColor,
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

              if (value == 'Edit') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            EditProduk(idxProduk: widget.produk.id)));
              } else if (value == 'Hapus') {
                handleDelete();
                Navigator.pop(context);
                Fluttertoast.showToast(
                  msg: 'Produk Berhasil Dihapus',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  backgroundColor: Colors.teal[300],
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem<String>(
                  value: 'Hapus',
                  child: Text('Hapus'),
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
                      ? Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 30),
                        child: Image.network(
                            widget.produk.img,
                            height: 200,
                          ),
                      )
                      : Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 30),
                        child: Image.file(
                            File(widget.produk.img),
                            height: 200,
                          ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 25, bottom: 16),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.produk.namaProduk,
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
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
                              TextStyle(color: Colors.teal[700], fontSize: 25),
                        )),
                  ),
                  widget.produk.deskripsi != ''
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 25, top: 25),
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.produk.deskripsi, style: const TextStyle(fontSize: 17),
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
                      const Text("Stok", style: TextStyle(fontSize: 17),),
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
                      const Text("Jumlah", style: TextStyle(fontSize: 17)),
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
                      const Text("Subtotal", style: TextStyle(fontSize: 17)),
                      Text(formatCurrency.format(
                          widget.produk.hargaJual * qtyProvider.getQty)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 25, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Pilih Metode Pembayaran", style: TextStyle(fontSize: 17)),
                      DropdownButton<String>(
                        value: transaksiProv.selectedMetodePembayaran,
                        items:
                            transaksiProv.metodePembayaran.map((String metode) {
                          return DropdownMenuItem<String>(
                            value: metode,
                            child: Text(metode),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          transaksiProv.setSelectedMetodePembayaran(newValue!);
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    minimumSize: const Size(365, 40),
                    backgroundColor: primaryColor,
                  ),
                  child: const Text(
                    'Buat Transaksi Baru',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    await transaksiProv.addTransaksi(
                      metodePembayaran: transaksiProv.selectedMetodePembayaran,
                      qty: qtyProvider.getQty,
                      price: widget.produk.hargaJual,
                      namaProduk: widget.produk.namaProduk,
                    );

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TransaksiListScreen()));
                    Fluttertoast.showToast(
                      msg: 'Transaksi Baru Berhasil Dibuat',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP,
                      backgroundColor: Colors.teal[300],
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
