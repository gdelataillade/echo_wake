import 'package:flutter/material.dart';

class AlarmSheetTimePicker extends StatelessWidget {
  final TimeOfDay selectedTime;

  const AlarmSheetTimePicker({super.key, required this.selectedTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Text(
            selectedTime.format(context),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
