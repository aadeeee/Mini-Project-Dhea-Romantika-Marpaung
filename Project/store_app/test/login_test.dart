import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:store_app/views/view_models/account_view_model.dart';
import 'package:store_app/views/screens/account/login.dart'; 
void main() {

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

    // testWidgets('Login button Testing', (WidgetTester tester) async {
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: ChangeNotifierProvider(
    //         create: (context) => AccountProvider(),
    //         child: const MyLogin(),
    //       ),
    //     ),
    //   );

    //   final usernameField = find.byKey(const Key('username'));
    //   final passwordField = find.byKey(const Key('password'));
    //   final loginButton = find.text("MASUK");

    //   await tester.enterText(usernameField, 'testusername');
    //   await tester.enterText(passwordField, 'test1234');

    //   await tester.tap(loginButton);
    //   await tester.pump();

    //   expect(find.byWidget(const MyApp()), findsOneWidget); 
    // });

}
