// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/produk_model.dart';
import 'package:store_app/view/view_models/form_produk.dart';
import 'package:store_app/view/view_models/img_view_model.dart';
import 'package:store_app/view/view_models/produk_view_model.dart';

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

      setState(() {
        
      });
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
        title: const Text('Edit Produk'),
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
                  decoration: const InputDecoration(
                      labelText: 'Nama Produk', border: OutlineInputBorder()),
                  validator: formProv.validateNamaProduk,
                ),
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

                              Navigator.pop(context);

                              Fluttertoast.showToast(
                                msg: 'Produk Berhasil Diedit',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                backgroundColor: Colors.teal[300],
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[700],
                        ),
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.fontSize,
                          ),
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
