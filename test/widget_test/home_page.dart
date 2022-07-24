import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_gadget_zone/blocs/category_bloc/category_bloc.dart';
import 'package:the_gadget_zone/blocs/home_content/home_content_bloc.dart';
import 'package:the_gadget_zone/screen/HomePage/home_page.dart';

void main() {
  testWidgets('Dashboard Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider(
          create: (context) => HomeContentBloc(),
        )
      ],
      child: MaterialApp(home: HomePage(),),
    ));

    final titlefinder = find.text('THEGADGETZONE');

    expect(titlefinder, findsOneWidget);
  });
}
