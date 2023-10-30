import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
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

  // testWidgets('Register button Testing', (WidgetTester tester) async {

  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: ChangeNotifierProvider(
  //         create: (context) => AccountProvider(),
  //         child: const MyRegister(),
  //       ),
  //     ),
  //   );

  //   final nameField = find.byKey(const Key('name'));
  //   final usernameField = find.byKey(const Key('username'));
  //   final genderField = find.byKey(const Key('gender'));
  //   final emailField = find.byKey(const Key('email'));
  //   final phoneField = find.byKey(const Key('phone'));
  //   final passwordField = find.byKey(const Key('password'));

  
  //   await tester.enterText(nameField, 'Dhea Marpaung');
  //   await tester.enterText(usernameField, 'Dhea');
  //   await tester.enterText(genderField, 'Perempuan');
  //   await tester.enterText(emailField, 'dhea@gmail.com');
  //   await tester.enterText(phoneField, '01234567891');
  //   await tester.enterText(passwordField, 'dhea2345');


  //   final registerButton = find.text("DAFTAR");

 
  //   await tester.tap(registerButton);
  //   print(AccountProvider().loggedIn);
  //   await tester.pumpAndSettle();

  //   expect(find.byType(MyLogin), findsOneWidget);
  // });
}
