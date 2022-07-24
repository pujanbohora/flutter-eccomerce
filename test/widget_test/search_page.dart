import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:the_gadget_zone/blocs/search_bloc/search_bloc.dart';
import 'package:the_gadget_zone/screen/HomePage/search/search.dart';

void main() {
  testWidgets('Account Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(BlocProvider(
      create: (context) => SearchBloc(),
      child: MaterialApp(home: SearchProduct()),
    ));

    final titlefinder = find.text('Search');

    expect(titlefinder, findsOneWidget);
  });
}
