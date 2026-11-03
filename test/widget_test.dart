import 'package:flutter_test/flutter_test.dart';
import 'package:raccoon_ai/main.dart';

void main() {
  testWidgets('shows the Raccoon AI foundation screen', (tester) async {
    await tester.pumpWidget(const RaccoonAiApp());

    expect(find.text('Raccoon AI'), findsOneWidget);
    expect(find.text('Hey, I’m Raccoon.'), findsOneWidget);
    expect(find.text('Local AI isn’t connected yet'), findsOneWidget);
  });
}
