import 'dart:convert';

List<Transaksi> dataFromJson(String str) =>
    List<Transaksi>.from(json.decode(str).map((x) => Transaksi.fromJson(x)));

String dataToJson(List<Transaksi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transaksi {
  List<String> listMetodePembayaran = [
    'Tunai',
    'OVO',
    'GoPay',
    'ShopeePay',
    'DANA'
  ];
  String id;
  int nomorAntrian;
  bool inProcess;
  String metodePembayaran;
  DateTime date;
  String time;
  Map<String, int> listProduk;
  List<String> listProdukAkhir;

  Transaksi({
    required this.id,
    required this.nomorAntrian,
    required this.inProcess,
    required this.metodePembayaran,
    required this.date,
    required this.time,
    required this.listProduk,
    required this.listProdukAkhir,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json['id'],
        nomorAntrian: json["nomorAntrian"],
        inProcess: json["inProcess"],
        metodePembayaran: json["metodePembayaran"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        listProduk: Map.from(json["listProduk"])
            .map((k, v) => MapEntry<String, int>(k, v)),
        listProdukAkhir:
            List<String>.from(json["listProdukAkhir"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "nomorAntrian": nomorAntrian,
        "inProcess": inProcess,
        "metodePembayaran": metodePembayaran,
        "date": date.toIso8601String(),
        "time": time,
        "listProduk":
            Map.from(listProduk).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "listProdukAkhir": List<dynamic>.from(listProdukAkhir.map((x) => x)),
      };
}
