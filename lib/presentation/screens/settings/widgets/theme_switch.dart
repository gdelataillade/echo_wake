import 'package:echo_wake/gen/strings.g.dart';
import 'package:echo_wake/presentation/blocs/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsThemeSwitch extends StatelessWidget {
  const SettingsThemeSwitch({super.key});

  IconData getIcon(ThemeMode themeMode) {
    return themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return Column(
          children: [
            ListTile(
              leading: Icon(getIcon(themeMode)),
              title: Text(context.t.theme),
              subtitle: Text(context.t.selectTheThemeForTheApp),
              trailing: DropdownButton<ThemeMode>(
                value: themeMode,
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text(context.t.system),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(context.t.light),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(context.t.dark),
                  ),
                ],
                onChanged: (mode) {
                  if (mode != null) {
                    context.read<ThemeCubit>().setTheme(mode);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
