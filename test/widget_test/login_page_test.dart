import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:the_gadget_zone/screen/auth/login.dart';

void main() {
  testWidgets('Login Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Login()));

    final titlefinder = find.text('SIGN IN');
    final usernameFinder = find.byKey(Key('username'));
    final passwordFinder = find.byKey(Key('password'));

    expect(titlefinder, findsOneWidget);
    expect(usernameFinder, findsOneWidget);
    expect(passwordFinder, findsOneWidget);
  });
}
