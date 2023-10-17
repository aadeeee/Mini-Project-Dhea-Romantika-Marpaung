import 'package:flutter/material.dart';

class ProdukFormProvider extends ChangeNotifier {
  TextEditingController namaProdukController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController stokController = TextEditingController();
  TextEditingController hargaJualController = TextEditingController();
  TextEditingController hargaBeliController = TextEditingController();

  int _editIdx = 0;
  get editIdx => _editIdx;
  set updateEditIdx(int newIdx) {
    _editIdx = newIdx;
  }

  bool _edited = true;
  get edited => _edited;
  set isEdited(val) {
    _edited = _edited || val;
  }

  String kategoriSelected = "none";
  get getKategoriSelected => kategoriSelected;

  set updateKategori(String kategori) {
    kategoriSelected = kategori;
  }

  get getNama => namaProdukController.text;

  get getDeskripsi => deskripsiController.text;

  get getStok => stokController.text;

  get getHargaJual => hargaJualController.text;

  get getHargaBeli => hargaBeliController.text;

  clearController() {
    namaProdukController.clear();
    deskripsiController.clear();
    hargaJualController.clear();
    stokController.clear();
    hargaBeliController.clear();
    updateKategori = "none";
  }
}
