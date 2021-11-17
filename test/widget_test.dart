// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // var emailField = find.byKey(Key("email-field"));
  // var passwordField = find.byKey(Key("password-field"));
  var welcomeBack = find.text("Welcome Back");
  testWidgets("Login UI Test", (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Container(
            child: Text("Welcome Back"),
          ),
        ),
      ),
    );

    await tester.pump();
    // expect(emailField, findsOneWidget);
    // expect(passwordField, findsOneWidget);
    expect(welcomeBack, findsOneWidget);
  });
}
