import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:store_app/views/screens/produk/daftar_produk.dart';
import 'package:store_app/views/view_models/produk_view_model.dart';

void main() {
  testWidgets('Test MyProduk Widget', (WidgetTester tester) async {
    final produkProvider = ProdukProvider();

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<ProdukProvider>.value(value: produkProvider),
          ],
          child: const MyProduk(),
        ),
      ),
    );

    expect(find.byType(TabBar), findsOneWidget);
    expect(find.byType(TabBarView), findsOneWidget);
  });
}
