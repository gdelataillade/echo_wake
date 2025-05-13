import 'package:echo_wake/gen/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:echo_wake/domain/services/storage.dart';

class SettingsSnoozePicker extends StatefulWidget {
  const SettingsSnoozePicker({super.key});

  @override
  State<SettingsSnoozePicker> createState() => _SettingsSnoozePickerState();
}

class _SettingsSnoozePickerState extends State<SettingsSnoozePicker> {
  static const String snoozeKey = 'settingsSnoozeDuration';
  static const List<int> snoozeOptions = [3, 5, 10, 15];
  int _selectedSnooze = 10;
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
      _selectedSnooze = _storage.getInt(snoozeKey) ?? 10;
      _loading = false;
    });
  }

  Future<void> _onSnoozeSelected(int value) async {
    setState(() {
      _selectedSnooze = value;
    });
    await _storage.setInt(snoozeKey, value);
  }

  void _showSnoozePicker() async {
    final int? picked = await showModalBottomSheet<int>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              context.t.snoozeDurationPicker,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            ...snoozeOptions.map(
              (option) => RadioListTile<int>(
                value: option,
                groupValue: _selectedSnooze,
                title: Text('$option ${context.t.minutes}'),
                onChanged: (value) {
                  if (value != null) {
                    Navigator.of(context).pop(value);
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
    if (picked != null) {
      await _onSnoozeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListTile(
      leading: const Icon(Icons.snooze_rounded),
      title: Text(context.t.snoozeDuration),
      subtitle: Text(context.t.snoozeDurationPickerDescription),
      trailing: Text('$_selectedSnooze min'),
      onTap: _showSnoozePicker,
    );
  }
}
