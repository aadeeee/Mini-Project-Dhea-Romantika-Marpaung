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
  int v;

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
    required this.v,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json["_id"],
        nomorAntrian: json["nomorAntrian"],
        inProcess: json["inProcess"],
        metodePembayaran: json["metodePembayaran"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        qty: json["qty"],
        price: json["price"],
        namaProduk: json["namaProduk"],
        v: json["__v"],
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
        "__v": v,
      };
}
