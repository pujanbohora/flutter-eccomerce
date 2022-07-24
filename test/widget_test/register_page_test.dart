import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:the_gadget_zone/blocs/register_bloc/register_bloc.dart';
import 'package:the_gadget_zone/blocs/validation_bloc/validation_bloc.dart';
import 'package:the_gadget_zone/screen/auth/signup.dart';

void main() {
  testWidgets('Registration Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => ValidationBloc(),
        )
      ],
      child: MaterialApp(home: Signup(),),
    ));

    final titlefinder = find.text('Welcome Sign up');

    expect(titlefinder, findsOneWidget);
  });
}
