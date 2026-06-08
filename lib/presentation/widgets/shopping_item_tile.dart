import 'package:flutter/material.dart';
import 'package:shopping_list/l10n/app_localizations.dart';

import '../../domain/entities/shopping_item.dart';

class ShoppingItemTile extends StatelessWidget {
  const ShoppingItemTile({
    super.key,
    required this.item,
    required this.onTogglePurchased,
    required this.onDelete,
    required this.onIncrease,
    required this.onDecrease,
  });

  final ShoppingItem item;
  final VoidCallback onTogglePurchased;
  final VoidCallback onDelete;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          decoration:
              item.isPurchased ? TextDecoration.lineThrough : TextDecoration.none,
          color: item.isPurchased
              ? Theme.of(context).colorScheme.outline
              : null,
        );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Checkbox(
              value: item.isPurchased,
              onChanged: (_) => onTogglePurchased(),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: textStyle),
                  Text(
                    '${l10n.quantity}: ${item.quantity}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: item.isPurchased ? null : onDecrease,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text('${item.quantity}'),
            IconButton(
              onPressed: item.isPurchased ? null : onIncrease,
              icon: const Icon(Icons.add_circle_outline),
            ),
            IconButton(
              onPressed: onDelete,
              tooltip: l10n.delete,
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}
