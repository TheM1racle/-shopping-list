import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/app.dart';
import 'package:shopping_list/core/di/providers.dart';
import 'package:shopping_list/data/datasources/local_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalStorage storage;

  setUp(() async {
    storage = LocalStorage();
    await storage.init(testPath: './test_hive');
  });

  testWidgets('shows shopping list title', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localStorageProvider.overrideWithValue(storage),
        ],
        child: const MaterialApp(home: ShoppingListApp()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Список покупок'), findsWidgets);
  });
}
