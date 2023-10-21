import 'dart:convert';

List<Transaksi> transaksiFromJson(String str) =>
    List<Transaksi>.from(json.decode(str).map((x) => Transaksi.fromJson(x)));

String transaksiToJson(List<Transaksi> transaksi) =>
    json.encode(List<dynamic>.from(transaksi.map((x) => x.toJson())));

class Transaksi {
  String id;
  int nomorAntrian;
  bool inProcess;
  String metodePembayaran;
  DateTime date;
  String time;
  int qty;
  int price;
  String namaProduk;

  Transaksi({
    required this.id,
    required this.nomorAntrian,
    required this.inProcess,
    required this.metodePembayaran,
    required this.date,
    required this.time,
    required this.qty,
    required this.price,
    required this.namaProduk,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json["_id"] ?? "",
        nomorAntrian: json["nomorAntrian"] ?? 0,
        inProcess: json["inProcess"] ?? false,
        metodePembayaran: json["metodePembayaran"] ?? "",
        date: DateTime.tryParse(json["date"] ?? "") ?? DateTime.now(),
        time: json["time"] ?? "",
        qty: json["qty"] ?? 0,
        price: json["price"] ?? 0,
        namaProduk: json["namaProduk"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nomorAntrian": nomorAntrian,
        "inProcess": inProcess,
        "metodePembayaran": metodePembayaran,
        "date": date.toIso8601String(),
        "time": time,
        "qty": qty,
        "price": price,
        "namaProduk": namaProduk,
      };
}
