// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:store_app/view/view_models/form_produk_view_model.dart';
import 'package:store_app/view/view_models/img_view_model.dart';
import 'package:store_app/view/view_models/produk_view_model.dart';

class TambahProduk extends StatefulWidget {
  const TambahProduk({super.key});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final produkProv = Provider.of<ProdukProvider>(context);
    final formProv = Provider.of<ProdukFormProvider>(context);
    final imgProv = Provider.of<ImgProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 35, bottom: 15),
                child: TextFormField(
                    controller: formProv.namaProdukController,
                    decoration: const InputDecoration(
                        labelText: 'Nama Produk', border: OutlineInputBorder()),
                    validator: formProv.validateNamaProduk),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: TextFormField(
                  controller: formProv.deskripsiController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      labelText: 'Deskripsi', border: OutlineInputBorder()),
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
                      labelText: 'Kategori', border: OutlineInputBorder()),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Gambar",
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.fontSize),
                      ),
                      OutlinedButton(
                          onPressed: imgProv.pickImage,
                          child: Text(
                            "Upload Gambar",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.fontSize),
                          )),
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  children: [
                    Text(
                      'Image :',
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge?.fontSize),
                    ),
                    Flexible(
                      child: Text(
                        imgProv.imagePath != null
                            ? basename('${imgProv.imagePath}')
                            : 'No Image Selected',
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
                    decoration: const InputDecoration(
                        labelText: 'Jumlah Stok', border: OutlineInputBorder()),
                    validator: formProv.validateStok),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: TextFormField(
                    controller: formProv.hargaBeliController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                    ],
                    decoration: const InputDecoration(
                        labelText: 'Harga Beli', border: OutlineInputBorder()),
                    validator: formProv.validateHarga),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: TextFormField(
                    controller: formProv.hargaJualController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,]'))
                    ],
                    decoration: const InputDecoration(
                        labelText: 'Harga Jual', border: OutlineInputBorder()),
                    validator: formProv.validateHarga),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 15, bottom: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (imgProv.imagePath == null) {
                              Fluttertoast.showToast(
                                msg:
                                    'Silahkan Pilih Gambar Produk Anda Terlebih Dahulu',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                backgroundColor: Colors.redAccent[700],
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else {
                              await produkProv.addProduk(
                                  namaProduk: formProv.getNama,
                                  img: '${imgProv.imagePath}',
                                  hargaJual: int.parse(formProv.getHargaJual
                                      .replaceAll(RegExp(r'[^0-9]'), '')),
                                  hargaBeli: int.parse(formProv.getHargaBeli
                                      .replaceAll(RegExp(r'[^0-9]'), '')),
                                  kategori: formProv.getKategoriSelected,
                                  deskripsi: formProv.getDeskripsi,
                                  stock: int.parse(formProv.getStok
                                      .replaceAll(RegExp(r'[^0-9]'), '')));

                              Navigator.pop(context);

                              Fluttertoast.showToast(
                                msg: 'Produk Berhasil Ditambahkan',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                backgroundColor: Colors.teal[300],
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              formProv.namaProdukController.clear();
                              formProv.deskripsiController.clear();
                              formProv.hargaJualController.clear();
                              formProv.stokController.clear();
                              formProv.hargaBeliController.clear();
                              formProv.updateKategori = "none";
                              imgProv.clearImage();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[700]),
                        child: Text(
                          'Tambah',
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.fontSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
