import 'package:flutter/material.dart';

class PaymentDone extends StatelessWidget {
  const PaymentDone({super.key, required this.nomorAntrean});

  final int nomorAntrean;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/payment-done.png'),
                const Text(
                  'Transaksi Berhasil!',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Yeay! Order pada antrian $nomorAntrean telah selesai diproses.',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Figtree',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal[700]),
                            onPressed: () {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                            child: const Text(
                              'Kembali ke Beranda',
                              style: TextStyle(fontSize: 16,color: Colors.white),
                             
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
