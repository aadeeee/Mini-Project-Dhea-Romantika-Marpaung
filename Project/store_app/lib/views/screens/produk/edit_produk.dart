// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/format.dart';
import 'package:store_app/models/produk_model.dart';
import 'package:store_app/views/view_models/form_produk_view_model.dart';
import 'package:store_app/views/view_models/img_view_model.dart';
import 'package:store_app/views/view_models/produk_view_model.dart';

class EditProduk extends StatefulWidget {
  final String idxProduk;
  const EditProduk({super.key, required this.idxProduk});

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  bool _dataAlreadyFetched = false;
  Future<void> initProdukData(BuildContext context) async {
    final produkProv = Provider.of<ProdukProvider>(context);
    final formProv = Provider.of<ProdukFormProvider>(context);
    final imgProv = Provider.of<ImgProvider>(context);

    try {
      await produkProv.getData();
      final produk = produkProv.produkList.firstWhere(
        (produk) => produk.id == widget.idxProduk,
      );
      if (!_dataAlreadyFetched) {
        formProv.namaProdukController.text = produk.namaProduk;
        formProv.deskripsiController.text = produk.deskripsi;
        formProv.kategoriSelected = produk.kategori;
        formProv.stokController.text = produk.stock.toString();
        formProv.hargaJualController.text = produk.hargaJual.toString();
        formProv.hargaBeliController.text = produk.hargaBeli.toString();
        _dataAlreadyFetched = true;
        imgProv.setImage = produk.img;
      }

      setState(() {});
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_dataAlreadyFetched) {
      initProdukData(context);
    }
    final formProv = Provider.of<ProdukFormProvider>(context);
    final imgProv = Provider.of<ImgProvider>(context);
    final produkProv = Provider.of<ProdukProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                formProv.clearController();
                Navigator.pop(context);
              },
            );
          },
        ),
        title: const Text('Edit Produk'),backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formProv.formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 35, bottom: 15),
                child: TextFormField(
                  controller: formProv.namaProdukController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                      labelText: 'Nama Produk', border: OutlineInputBorder(), hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),),
                  validator: formProv.validateNamaProduk,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: TextFormField(
                  controller: formProv.deskripsiController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      labelText: 'Deskripsi', border: OutlineInputBorder(),hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),),
                  maxLines: null,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: DropdownButtonFormField(
                  items: produkProv.dropdownItems,
                  value: formProv.getKategoriSelected,
                  decoration: const InputDecoration(
                      labelText: 'Kategori', border: OutlineInputBorder(),hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),),
                  validator: (value) => (value == null || value == "none")
                      ? "Pilih kategori"
                      : null,
                  onChanged: (val) {
                    formProv.kategoriSelected = val as String;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  children: [
                    Text(
                      'Image :',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge?.fontSize,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        basename('${imgProv.imagePath}'),
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium?.fontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: TextFormField(
                    controller: formProv.stokController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                        labelText: 'Jumlah Stok', border: OutlineInputBorder(),hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),),
                    validator: formProv.validateStok),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: TextFormField(
                    controller: formProv.hargaBeliController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                    ],
                    decoration: const InputDecoration(
                        labelText: 'Harga Beli', border: OutlineInputBorder(),hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),),
                    validator: formProv.validateHarga,
                    onChanged: (value) {
                    final cleanValue = value.replaceAll(RegExp(r'[^\d]'), '');
                    final formattedValue =
                        formatCurrency.format(int.parse(cleanValue));
                    formProv.hargaBeliController.value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                          offset: formattedValue.length),
                    );
                  },),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: TextFormField(
                    controller: formProv.hargaJualController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,]'))
                    ],
                    decoration: const InputDecoration(
                        labelText: 'Harga Jual', border: OutlineInputBorder(),hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),),
                    validator: formProv.validateHarga,
                    onChanged: (value) {
                    final cleanValue = value.replaceAll(RegExp(r'[^\d]'), '');
                    final formattedValue =
                        formatCurrency.format(int.parse(cleanValue));
                    formProv.hargaJualController.value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                          offset: formattedValue.length),
                    );
                  }
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 25, bottom: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formProv.edited) {
                            if (formProv.formKey.currentState!.validate()) {
                              await produkProv.updateProduk(Produk(
                                id: widget.idxProduk,
                                namaProduk: formProv.namaProdukController.text,
                                img: '${imgProv.imagePath}',
                                hargaJual: int.parse(formProv
                                    .hargaJualController.text
                                    .replaceAll(RegExp(r'[^0-9]'), '')),
                                hargaBeli: int.parse(formProv
                                    .hargaBeliController.text
                                    .replaceAll(RegExp(r'[^0-9]'), '')),
                                kategori: formProv.kategoriSelected,
                                deskripsi: formProv.deskripsiController.text,
                                stock: int.parse(formProv.stokController.text
                                    .replaceAll(RegExp(r'[^0-9]'), '')),
                              ));
                              
                              await produkProv.getData();

                              Navigator.popUntil(
                                  context, (route) => route.isFirst);

                              Fluttertoast.showToast(
                                msg: 'Produk Berhasil Diedit',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                backgroundColor: Colors.teal[300],
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                            formProv.namaProdukController.clear();
                              formProv.deskripsiController.clear();
                              formProv.hargaJualController.clear();
                              formProv.stokController.clear();
                              formProv.hargaBeliController.clear();
                              formProv.updateKategori = "none";
                              imgProv.clearImage();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          minimumSize: const Size(365, 40),
                          backgroundColor: primaryColor,
                        ),
                        child: Text(
                          'SIMPAN',
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.fontSize,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
