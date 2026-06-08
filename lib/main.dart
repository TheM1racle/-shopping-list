import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/di/providers.dart';
import 'data/datasources/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = LocalStorage();
  await storage.init();

  runApp(
    ProviderScope(
      overrides: [
        localStorageProvider.overrideWithValue(storage),
      ],
      child: const BootstrapApp(),
    ),
  );
}

class BootstrapApp extends ConsumerStatefulWidget {
  const BootstrapApp({super.key});

  @override
  ConsumerState<BootstrapApp> createState() => _BootstrapAppState();
}

class _BootstrapAppState extends ConsumerState<BootstrapApp> {
  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    final notificationService = ref.read(notificationServiceProvider);
    final sessionService = ref.read(shoppingSessionServiceProvider);
    final shoppingNotifier = ref.read(shoppingNotifierProvider.notifier);

    await notificationService.init(
      onNotificationTap: (payload) async {
        await sessionService.handleNotificationTap(
          itemId: payload,
          notificationTitle: 'Next item',
          boughtLabel: 'Tap to mark as bought',
          onItemsChanged: shoppingNotifier.loadItems,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ShoppingListApp();
  }
}
