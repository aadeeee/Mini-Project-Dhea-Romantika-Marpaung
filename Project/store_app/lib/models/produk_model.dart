import 'dart:convert';

List<Produk> dataFromJson(String str) =>
    List<Produk>.from(json.decode(str).map((x) => Produk.fromJson(x)));

String dataToJson(List<Produk> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Produk {
  String id;
  String namaProduk;
  String img;
  int hargaJual;
  int hargaBeli;
  String kategori;
  String deskripsi;
  int stock;

  Produk({
    required this.id,
    required this.namaProduk,
    required this.img,
    required this.hargaJual,
    required this.hargaBeli,
    required this.kategori,
    required this.deskripsi,
    required this.stock,
  });

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        id: json["id"],
        namaProduk: json["namaProduk"],
        img: json["img"],
        hargaJual: json["hargaJual"],
        hargaBeli: json["hargaBeli"],
        kategori: json["kategori"],
        deskripsi: json["deskripsi"],
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "namaProduk": namaProduk,
        "img": img,
        "hargaJual": hargaJual,
        "hargaBeli": hargaBeli,
        "kategori": kategori,
        "deskripsi": deskripsi,
        "stock": stock,
      };

  
}


