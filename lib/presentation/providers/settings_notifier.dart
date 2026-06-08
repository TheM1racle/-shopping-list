import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsState {
  const SettingsState({
    this.settings = const AppSettings(),
    this.isLoading = true,
  });

  final AppSettings settings;
  final bool isLoading;

  SettingsState copyWith({
    AppSettings? settings,
    bool? isLoading,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier(this._repository) : super(const SettingsState()) {
    loadSettings();
  }

  final SettingsRepository _repository;

  Future<void> loadSettings() async {
    state = state.copyWith(isLoading: true);
    final settings = await _repository.getSettings();
    state = state.copyWith(settings: settings, isLoading: false);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final updated = state.settings.copyWith(themeMode: mode);
    state = state.copyWith(settings: updated);
    await _repository.saveSettings(updated);
  }

  Future<void> setLocale(Locale locale) async {
    final updated = state.settings.copyWith(locale: locale);
    state = state.copyWith(settings: updated);
    await _repository.saveSettings(updated);
  }
}
