import 'package:example/pages/quiz/form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol_finders/patrol_finders.dart';

void main() {
  testWidgets(
    'counter is incremented when plus button is tapped',
    (tester) async {
      final $ = PatrolTester(
        tester: tester,
        config: const PatrolTesterConfig(),
      );
      const color = Colors.blue;
      await $.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SelectableBox(
              color: color,
              selected: true,
            ),
          ),
        ),
      );
      // await $(SelectableBox).tap();
      // expect(selected, true);
      expect($(SelectableBox).containing($(Icons.check_circle)), findsOneWidget);
    },
  );
}
