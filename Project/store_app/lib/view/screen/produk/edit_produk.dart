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
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> kategori = [
      const DropdownMenuItem(
          value: "none", child: Text("Pilih Kategori Produk")),
      const DropdownMenuItem(value: "ATK", child: Text("ATK")),
      const DropdownMenuItem(
          value: "Craft Supply", child: Text("Craft Supply")),
      const DropdownMenuItem(
          value: "Keperluan Jahit", child: Text("Keperluan Jahit")),
      const DropdownMenuItem(value: "Dekorasi", child: Text("Dekorasi")),
    ];
    return kategori;
  }

  List semuaKategori = [
    'ATK',
    'Craft Supply',
    'Keperluan Jahit',
    'Dekorasi',
  ];


  @override
  Widget build(BuildContext context) {
    final produkProv = Provider.of<ProdukProvider>(context);
    final formProv = Provider.of<ProdukFormProvider>(context);
    final imgProv = Provider.of<ImgProvider>(context);

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
          key: _formKey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 35, bottom: 15),
              child: TextFormField(
                controller: formProv.namaProdukController,
                decoration: const InputDecoration(
                    labelText: 'Nama Produk', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama Produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: TextFormField(
                controller: formProv.deskripsiController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder()),
                maxLines: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: DropdownButtonFormField(
                items: dropdownItems,
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gambar",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge?.fontSize),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                          : 'Image Not Found',
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: TextFormField(
                controller: formProv.stokController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Jumlah Stok', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Jumlah Stok tidak boleh kosong";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: TextFormField(
                controller: formProv.hargaBeliController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                ],
                decoration: const InputDecoration(
                    labelText: 'Harga Beli', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harga Beli tidak boleh kosong";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: TextFormField(
                controller: formProv.hargaJualController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                ],
                decoration: const InputDecoration(
                    labelText: 'Harga Jual', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harga Jual tidak boleh kosong";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 25, bottom: 50),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formProv.edited) {
                          if (_formKey.currentState!.validate()) {
                            produkProv.updateProduk(Produk(
                                id: widget.idxProduk,
                                namaProduk: formProv.getNama,
                                img: '${imgProv.imagePath}',
                                hargaJual: int.parse(formProv.getHargaJual
                                    .replaceAll(RegExp(r'[^0-9]'), '')),
                                hargaBeli: int.parse(formProv.getHargaBeli
                                    .replaceAll(RegExp(r'[^0-9]'), '')),
                                kategori: formProv.getKategoriSelected,
                                deskripsi: formProv.getDeskripsi,
                                stock: int.parse(formProv.getStok
                                    .replaceAll(RegExp(r'[^0-9]'), ''))));

                            Navigator.pop(context);

                            Fluttertoast.showToast(
                              msg: 'Produk Berhasil Diedit',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.TOP,
                              backgroundColor: Colors.teal[300],
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );

                            formProv.clearController();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[700],
                      ),
                      child: Text(
                        'Simpan',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium?.fontSize,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        )));
  }
}
