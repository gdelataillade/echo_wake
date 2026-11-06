import 'package:echo_wake/domain/services/storage.dart';
import 'package:echo_wake/gen/strings.g.dart';
import 'package:echo_wake/presentation/screens/settings/widgets/snooze_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late StorageService storage;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    storage = await StorageService.getInstance();
  });

  setUp(() async {
    await storage.clear();
  });

  Future<void> pumpPicker(WidgetTester tester) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: const MaterialApp(home: Scaffold(body: SettingsSnoozePicker())),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> openPicker(WidgetTester tester) async {
    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();
  }

  testWidgets('defaults to ten minutes and saves each snooze choice', (
    tester,
  ) async {
    await pumpPicker(tester);
    expect(find.text('10 min'), findsOneWidget);

    for (final minutes in [3, 5, 15, 10]) {
      await openPicker(tester);
      expect(find.byType(RadioListTile<int>), findsNWidgets(4));
      await tester.tap(find.text('$minutes ${t.minutes}'));
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheet), findsNothing);
      expect(find.text('$minutes min'), findsOneWidget);
      expect(storage.getInt('settingsSnoozeDuration'), minutes);
    }
  });

  testWidgets('loads the saved snooze choice and preserves it on dismissal', (
    tester,
  ) async {
    await storage.setInt('settingsSnoozeDuration', 15);
    await pumpPicker(tester);
    expect(find.text('15 min'), findsOneWidget);

    await openPicker(tester);
    final selected = tester.widget<Radio<int>>(
      find.byWidgetPredicate(
        (widget) => widget is Radio<int> && widget.value == 15,
      ),
    );
    expect(
      RadioGroup.maybeOf<int>(
        tester.element(find.byWidget(selected)),
      )?.groupValue,
      15,
    );

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheet), findsNothing);
    expect(find.text('15 min'), findsOneWidget);
    expect(storage.getInt('settingsSnoozeDuration'), 15);
  });
}
