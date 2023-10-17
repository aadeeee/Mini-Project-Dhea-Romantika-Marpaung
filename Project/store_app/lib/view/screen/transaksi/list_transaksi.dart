import 'package:flutter/material.dart';



class ListTransaksi extends StatefulWidget {
  const ListTransaksi({super.key});

  @override
  State<ListTransaksi> createState() => _ListTransaksiState();
}

class _ListTransaksiState extends State<ListTransaksi> {
  @override
  Widget build(BuildContext context) {
   
    

    return const Padding(
     padding: EdgeInsets.all(10),
     child: Text("list Transkasi"),
    );
  }
}
