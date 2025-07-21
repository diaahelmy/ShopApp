import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/log_addacount/cubit/themes/ThemeCubit.dart';

class SwitchThemes extends StatelessWidget {
  const SwitchThemes({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Theme"),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        color: theme.scaffoldBackgroundColor,
        child: BlocBuilder<ThemeCubit, AppThemeMode>(
          builder: (context, currentTheme) {
            final cubit = context.read<ThemeCubit>();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your preferred theme:",
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      RadioListTile<AppThemeMode>(
                        title: const Text("🌞 Light Mode"),
                        value: AppThemeMode.light,
                        groupValue: currentTheme,
                        onChanged: (mode) {
                          if (mode != null) cubit.setTheme(mode);
                        },
                      ),
                      RadioListTile<AppThemeMode>(
                        title: const Text("🌙 Dark Mode"),
                        value: AppThemeMode.dark,
                        groupValue: currentTheme,
                        onChanged: (mode) {
                          if (mode != null) cubit.setTheme(mode);
                        },
                      ),
                      RadioListTile<AppThemeMode>(
                        title: const Text("💻 System Default"),
                        value: AppThemeMode.system,
                        groupValue: currentTheme,
                        onChanged: (mode) {
                          if (mode != null) cubit.setTheme(mode);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}