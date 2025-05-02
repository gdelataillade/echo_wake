import 'package:flutter/material.dart';

class AlarmErrorScreen extends StatelessWidget {
  final String message;

  const AlarmErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: colorScheme.error),
          const SizedBox(height: 16),
          Text(
            'Error: $message',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: colorScheme.error),
          ),
        ],
      ),
    );
  }
}
