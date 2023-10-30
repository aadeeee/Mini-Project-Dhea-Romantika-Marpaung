import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/views/screens/home/buttom_navbar.dart';
import 'package:store_app/views/view_models/buttom_navigation_view_model.dart';
import 'package:store_app/views/view_models/transaksi_view_model.dart';
import 'package:store_app/views/view_models/produk_view_model.dart';
import 'package:store_app/views/view_models/recomendation_view_model.dart';
import 'package:store_app/views/screens/home/insight_page.dart';

void main() {
  testWidgets('BottomNavbar UI Testing', (WidgetTester tester) async {
    final bottomNavProvider = BottomNavbarProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => bottomNavProvider),
        ],
        child: const MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNavbar(),
          ),
        ),
      ),
    );
    await tester.tap(find.byIcon(Icons.home));
    await tester.pump();
    expect(bottomNavProvider.getSelectedIdx, 0);

    await tester.tap(find.byIcon(Icons.store));
    await tester.pump();
    expect(bottomNavProvider.getSelectedIdx, 1);

    await tester.tap(find.byIcon(Icons.receipt_long));
    await tester.pump();
    expect(bottomNavProvider.getSelectedIdx, 2);

    await tester.tap(find.byIcon(Icons.person));
    await tester.pump();
    expect(bottomNavProvider.getSelectedIdx, 3);
  });
  testWidgets('Test HomeInsight Widget', (WidgetTester tester) async {
    final transaksiProvider = TransaksiProvider();
    final produkProvider = ProdukProvider();
    final aiProvider = RecomendationProvider();

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<TransaksiProvider>.value(
                value: transaksiProvider),
            ChangeNotifierProvider<ProdukProvider>.value(value: produkProvider),
            ChangeNotifierProvider<RecomendationProvider>.value(
                value: aiProvider),
          ],
          child: const HomeInsight(),
        ),
      ),
    );

    expect(find.text("Profit Bulanan"), findsOneWidget);
    expect(find.text("Produk Terjual"), findsOneWidget);
    expect(find.text("Transaksi"), findsOneWidget);
    expect(find.text("Produk Rekomendasi"), findsOneWidget);
    expect(find.text("Produk Hampir Habis"), findsOneWidget);
  });
}
