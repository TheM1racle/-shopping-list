import 'package:flutter/material.dart';

import '../../domain/entities/app_settings.dart';

class AppSettingsModel {
  AppSettingsModel({
    required this.themeModeIndex,
    required this.languageCode,
  });

  final int themeModeIndex;
  final String languageCode;

  factory AppSettingsModel.fromEntity(AppSettings entity) {
    return AppSettingsModel(
      themeModeIndex: entity.themeMode.index,
      languageCode: entity.locale.languageCode,
    );
  }

  AppSettings toEntity() {
    return AppSettings(
      themeMode: ThemeMode.values[themeModeIndex.clamp(0, ThemeMode.values.length - 1)],
      locale: Locale(languageCode),
    );
  }

  factory AppSettingsModel.fromMap(Map<dynamic, dynamic> map) {
    return AppSettingsModel(
      themeModeIndex: map['themeModeIndex'] as int? ?? ThemeMode.system.index,
      languageCode: map['languageCode'] as String? ?? 'ru',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'themeModeIndex': themeModeIndex,
      'languageCode': languageCode,
    };
  }
}
