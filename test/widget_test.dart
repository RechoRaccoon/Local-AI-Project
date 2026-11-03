import 'package:flutter_test/flutter_test.dart';
import 'package:raccoon_ai/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('shows the redesigned Raccoon AI home screen', (tester) async {
    await tester.pumpWidget(const RaccoonAiApp());

    expect(find.text('RACCOON'), findsOneWidget);
    expect(find.text('At your side.'), findsOneWidget);
    expect(find.text('LOCAL MODEL NOT CONNECTED'), findsOneWidget);
  });

  testWidgets('opens settings and toggles mascot motion', (tester) async {
    await tester.pumpWidget(const RaccoonAiApp());
    await tester.tap(find.byTooltip('Settings'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('Mascot animations'), findsOneWidget);
    expect(find.text('On-device processing'), findsOneWidget);

    final toggle = tester.widget<SwitchListTile>(
      find.widgetWithText(SwitchListTile, 'Mascot animations'),
    );
    expect(toggle.value, isTrue);

    await tester.tap(find.byType(Switch).first);
    await tester.pump();

    final updatedToggle = tester.widget<SwitchListTile>(
      find.widgetWithText(SwitchListTile, 'Mascot animations'),
    );
    expect(updatedToggle.value, isFalse);
  });
}
