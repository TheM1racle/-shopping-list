import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local_storage.dart';
import '../../data/datasources/settings_local_datasource.dart';
import '../../data/datasources/shopping_local_datasource.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/shopping_repository_impl.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/shopping_repository.dart';
import '../../presentation/providers/settings_notifier.dart';
import '../../presentation/providers/shopping_notifier.dart';
import '../services/notification_service.dart';
import '../services/shopping_session_service.dart';

final localStorageProvider = Provider<LocalStorage>((ref) {
  throw UnimplementedError('LocalStorage must be overridden in main.dart');
});

final shoppingDatasourceProvider = Provider<ShoppingLocalDatasource>((ref) {
  return ShoppingLocalDatasource(ref.watch(localStorageProvider));
});

final settingsDatasourceProvider = Provider<SettingsLocalDatasource>((ref) {
  return SettingsLocalDatasource(ref.watch(localStorageProvider));
});

final shoppingRepositoryProvider = Provider<ShoppingRepository>((ref) {
  return ShoppingRepositoryImpl(ref.watch(shoppingDatasourceProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(ref.watch(settingsDatasourceProvider));
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

final shoppingSessionServiceProvider = Provider<ShoppingSessionService>((ref) {
  return ShoppingSessionService(
    notificationService: ref.watch(notificationServiceProvider),
    shoppingRepository: ref.watch(shoppingRepositoryProvider),
  );
});

final shoppingNotifierProvider =
    StateNotifierProvider<ShoppingNotifier, ShoppingState>((ref) {
  return ShoppingNotifier(ref.watch(shoppingRepositoryProvider));
});

final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier(ref.watch(settingsRepositoryProvider));
});
