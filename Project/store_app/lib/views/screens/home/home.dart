import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/views/screens/home/insight_page.dart';
import 'package:store_app/views/view_models/account_view_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 40),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Hai, ${accountProvider.loggedInUsername}!',
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20, top: 15),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Masih semangat jualan hari ini???',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontFamily: "Poppins"),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const HomeInsight(),
        ],
      ),
    );
  }
}
