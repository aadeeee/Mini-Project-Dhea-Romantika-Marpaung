import 'package:flutter/material.dart';

import 'package:store_app/view/screen/home/insight_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Hai, Dhea!',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Figtree',
                    fontSize: 24),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'masih semangat jualan hari ini?',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Figtree',
                    fontSize: 16),
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


