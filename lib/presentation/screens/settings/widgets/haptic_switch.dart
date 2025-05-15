import 'package:echo_wake/core/utils/helper.dart';
import 'package:echo_wake/domain/services/storage.dart';
import 'package:echo_wake/gen/strings.g.dart';
import 'package:flutter/material.dart';

/// A switch tile for toggling haptic feedback, with persistent storage and Helper update.
class HapticSwitch extends StatefulWidget {
  /// Optional callback when the haptic setting changes.
  final ValueChanged<bool>? onChanged;
  const HapticSwitch({super.key, this.onChanged});

  @override
  State<HapticSwitch> createState() => _HapticSwitchState();
}

class _HapticSwitchState extends State<HapticSwitch> {
  static const String hapticKey = 'settingsHapticFeedback';
  bool _hapticEnabled = true;
  bool _loading = true;
  late StorageService _storage;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _storage = await StorageService.getInstance();
    setState(() {
      _hapticEnabled = _storage.getBool(hapticKey) ?? true;
      _loading = false;
    });
  }

  Future<void> _onChanged(bool value) async {
    setState(() {
      _hapticEnabled = value;
    });
    await _storage.setBool(hapticKey, value);
    Helper.hapticEnabled = value;
    Helper.lightHapticFeedback();
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return SwitchListTile.adaptive(
      value: _hapticEnabled,
      onChanged: _onChanged,
      title: Text(context.t.hapticFeedback),
      subtitle: Text(context.t.hapticFeedbackDescription),
      secondary: const Icon(Icons.vibration),
    );
  }
}
