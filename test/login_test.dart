import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sign_in_flutter/Screens/login_screen.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Login screen test', (WidgetTester tester) async {
    LoginPage loginScreen = LoginPage();

    await tester.pumpWidget(makeTestableWidget(child: loginScreen));

    expect(find.byType(OutlineButton), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);

    print('Found Flutter logo.');
    print('Button found.');
    print('Found the login button text.');
  });
}
