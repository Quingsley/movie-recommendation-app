import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/widgets/primary_button.dart';

void main() {
  testWidgets('Given a Primary Button find -- text Yes Please', (tester) async {
    const text = 'Yes Please';

    await tester.pumpWidget(
        MaterialApp(home: PrimaryButton(text: text, onPressed: () {})));

    expect(find.text(text), findsOneWidget);
  });

  testWidgets(
      'Given a Primary Button and isLoading is true -- Circular progress indicator should be present',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
        home: PrimaryButton(
      text: 'Yes',
      onPressed: () {},
      isLoading: true,
    )));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
