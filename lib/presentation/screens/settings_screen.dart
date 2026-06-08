import 'package:flutter/material.dart';
import 'package:shopping_list/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(settingsNotifierProvider);
    final notifier = ref.read(settingsNotifierProvider.notifier);
    final isWide = MediaQuery.sizeOf(context).width >= 900;

    Widget content = ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(l10n.theme, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        SegmentedButton<ThemeMode>(
          segments: [
            ButtonSegment(
              value: ThemeMode.light,
              label: Text(l10n.themeLight),
              icon: const Icon(Icons.light_mode),
            ),
            ButtonSegment(
              value: ThemeMode.dark,
              label: Text(l10n.themeDark),
              icon: const Icon(Icons.dark_mode),
            ),
            ButtonSegment(
              value: ThemeMode.system,
              label: Text(l10n.themeSystem),
              icon: const Icon(Icons.settings_brightness),
            ),
          ],
          selected: {state.settings.themeMode},
          onSelectionChanged: (selection) {
            notifier.setThemeMode(selection.first);
          },
        ),
        const SizedBox(height: 24),
        Text(l10n.language, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: [
            ButtonSegment(
              value: 'ru',
              label: Text(l10n.languageRu),
            ),
            ButtonSegment(
              value: 'en',
              label: Text(l10n.languageEn),
            ),
          ],
          selected: {state.settings.locale.languageCode},
          onSelectionChanged: (selection) {
            notifier.setLocale(Locale(selection.first));
          },
        ),
      ],
    );

    if (isWide) {
      content = Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: content,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : content,
    );
  }
}
