import 'package:flutter/material.dart';
import 'package:shopping_list/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../widgets/add_item_form.dart';
import '../widgets/shopping_item_tile.dart';

class ShoppingListScreen extends ConsumerStatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ConsumerState<ShoppingListScreen> createState() =>
      _ShoppingListScreenState();
}

class _ShoppingListScreenState extends ConsumerState<ShoppingListScreen> {
  bool _sessionActive = false;

  Future<void> _toggleShoppingSession() async {
    final l10n = AppLocalizations.of(context)!;
    final session = ref.read(shoppingSessionServiceProvider);
    final notifier = ref.read(shoppingNotifierProvider.notifier);

    if (_sessionActive) {
      await session.stop();
      setState(() => _sessionActive = false);
      return;
    }

    final unpurchased = ref
        .read(shoppingNotifierProvider)
        .items
        .where((item) => !item.isPurchased)
        .toList();

    if (unpurchased.isEmpty) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.noUnpurchasedItems)),
      );
      return;
    }

    await session.start(
      notificationTitle: l10n.nextItem,
      boughtLabel: l10n.tapToMarkBought,
      onItemsChanged: notifier.loadItems,
    );
    setState(() => _sessionActive = true);

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.shoppingActive)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(shoppingNotifierProvider);
    final notifier = ref.read(shoppingNotifierProvider.notifier);
    final isWide = MediaQuery.sizeOf(context).width >= 900;

    Widget content = Column(
      children: [
        AddItemForm(
          onSubmit: (name, quantity) => notifier.addItem(name, quantity),
        ),
        Expanded(
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.items.isEmpty
                  ? Center(child: Text(l10n.emptyList))
                  : ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return ShoppingItemTile(
                          item: item,
                          onTogglePurchased: () =>
                              notifier.togglePurchased(item.id),
                          onDelete: () => notifier.deleteItem(item.id),
                          onIncrease: () =>
                              notifier.changeQuantity(item.id, 1),
                          onDecrease: () =>
                              notifier.changeQuantity(item.id, -1),
                        );
                      },
                    ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton.tonalIcon(
              onPressed: _toggleShoppingSession,
              icon: Icon(_sessionActive ? Icons.stop : Icons.shopping_bag),
              label: Text(
                _sessionActive ? l10n.stopShopping : l10n.goShopping,
              ),
            ),
          ),
        ),
      ],
    );

    if (isWide) {
      content = Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: content,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.shoppingList)),
      body: content,
    );
  }
}
