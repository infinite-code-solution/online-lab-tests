import 'package:flutter_test/flutter_test.dart';

import 'package:online_lab_tests/main.dart';

void main() {
  testWidgets('Home page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BookMyTestApp());

    // Verify the app title is rendered.
    expect(find.text('Book My Test'), findsOneWidget);

    // Verify the search bar placeholder is present.
    expect(find.text('Search tests, packages or scans'), findsOneWidget);
  });
}

