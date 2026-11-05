# Echo Wake

Personal alarm and timer app where your own voice becomes the wake-up call.

## iOS development

Selected compatibility toolchain: Flutter **3.47.5** (revision `6a19cca564`),
Dart **3.13.4**, Xcode **27.0** (`27A266a`), CocoaPods **1.16.2**.
The Dart constraint matches the SDK packages' minimum of 3.11; the selected
Flutter baseline is 3.47.5. Other toolchain versions have not been validated.

The iOS deployment target is **15.0**, matching this Flutter SDK's minimum.
This drops the old iOS 13/14 app targets; it does not add AlarmKit.
The existing `alarm` and recording integrations remain in place.

Keep `pubspec.lock` and `ios/Podfile.lock` when resolving dependencies.
`intl` follows `flutter_localizations`' 0.20.3 constraint. Swift Package Manager
is disabled for this project to retain the locked CocoaPods integration without
a second native-dependency migration; this is a compatibility baseline, not a
long-term dependency-manager policy. See Flutter's
[project configuration](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers#turn-off-swiftpm-for-a-single-project).
The Runner scheme uses Flutter's generated LLDB initialization for current iOS
debugging. Open `ios/Runner.xcworkspace` when working in Xcode.
Flutter also adds analyzer exclusions for build output and native platform
directories automatically; app Dart code and tests remain analyzed.

```sh
flutter pub get --enforce-lockfile
dart format --output=none --set-exit-if-changed lib/presentation/screens/settings/widgets/snooze_picker.dart test/presentation/screens/settings/widgets/snooze_picker_test.dart
flutter analyze lib test
flutter test test/presentation/screens/settings/widgets/snooze_picker_test.dart
flutter build ios --simulator --debug --no-codesign
flutter build ios --release --no-codesign
```

The release command checks device compilation without signing or installing an
app. Neither build verifies physical-device alarm delivery or audio playback.
Android upgrades and validation are deferred.

## Manual iPhone smoke check

Using the selected toolchain and your existing signing setup, install this
branch with `flutter run -d <device-id>` (or run the Runner workspace in Xcode).

1. Launch the app and check navigation between alarms, recordings and settings.
2. In Settings, open Snooze, choose each of 3/5/10/15 minutes, reopen the sheet,
   then dismiss it without choosing. Confirm the last choice is retained after
   closing and reopening the app.
3. Record a short non-private voice note, preview it, and use it for an alarm
   a few minutes ahead. Confirm existing recordings remain available.
4. Lock the phone; confirm the alarm rings with the selected audio, then check
   Snooze and Stop. These are checks of the existing alarm integration.

Record the device, iOS version, commit and results. Simulator/device compilation
and widget tests do not replace this smoke check or broader alarm reliability QA.
