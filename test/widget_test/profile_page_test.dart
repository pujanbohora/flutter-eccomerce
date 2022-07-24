import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_gadget_zone/blocs/profile_bloc/profile_bloc.dart';
import 'package:the_gadget_zone/screen/HomePage/profile/profile.dart';

void main() {
  testWidgets('Profile Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(BlocProvider(
      create: ((context) => ProfileBloc()),
      child: MaterialApp(home: Profile()),
    ));

    final titlefinder = find.text('Profiled');
    final oldPswFinder = find.byKey(Key('oldpsw'));

    expect(titlefinder, findsNWidgets(2));
    expect(oldPswFinder, findsOneWidget);
  });
}
