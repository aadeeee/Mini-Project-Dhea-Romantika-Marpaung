import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:store_app/views/screens/account/login.dart';
import 'package:store_app/views/view_models/account_view_model.dart';
import 'package:store_app/views/screens/account/register.dart';

void main() {
  testWidgets('Register UI Testing', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => AccountProvider(),
          child: const MyRegister(),
        ),
      ),
    );

    expect(find.text('Nama Lengkap'), findsOneWidget);
    expect(find.text('Nama Pengguna'), findsOneWidget);
    expect(find.text('Jenis Kelamin'), findsOneWidget);
    expect(find.text('No.Telepon'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Kata Sandi'), findsOneWidget);

    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Login UI Testing', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => AccountProvider(),
          child: const MyLogin(),
        ),
      ),
    );

    expect(find.text('Nama Pengguna'), findsOneWidget);
    expect(find.text('Kata Sandi'), findsOneWidget);

    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
