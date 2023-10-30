import 'package:flutter/material.dart';
import 'package:store_app/const/format.dart';

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
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Yeay! Order pada antrian $nomorAntrean telah selesai diproses.',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              minimumSize: const Size(365, 40),
                              backgroundColor: primaryColor,
                            ),
                            onPressed: () {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                            child: const Text(
                              'Kembali ke Beranda',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: "Poppins"),
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
