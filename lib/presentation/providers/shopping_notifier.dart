import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/shopping_item.dart';
import '../../domain/repositories/shopping_repository.dart';

class ShoppingState {
  const ShoppingState({
    this.items = const [],
    this.isLoading = true,
    this.error,
  });

  final List<ShoppingItem> items;
  final bool isLoading;
  final String? error;

  ShoppingState copyWith({
    List<ShoppingItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return ShoppingState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ShoppingNotifier extends StateNotifier<ShoppingState> {
  ShoppingNotifier(this._repository) : super(const ShoppingState()) {
    loadItems();
  }

  final ShoppingRepository _repository;
  final _uuid = const Uuid();

  Future<void> loadItems() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final items = await _repository.getItems();
      state = state.copyWith(items: items, isLoading: false);
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  Future<void> addItem(String name, int quantity) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty || quantity < 1) {
      return;
    }

    final item = ShoppingItem(
      id: _uuid.v4(),
      name: trimmed,
      quantity: quantity,
    );
    await _repository.addItem(item);
    await loadItems();
  }

  Future<void> deleteItem(String id) async {
    await _repository.deleteItem(id);
    await loadItems();
  }

  Future<void> togglePurchased(String id) async {
    final item = state.items.firstWhere((element) => element.id == id);
    await _repository.updateItem(item.copyWith(isPurchased: !item.isPurchased));
    await loadItems();
  }

  Future<void> changeQuantity(String id, int delta) async {
    final item = state.items.firstWhere((element) => element.id == id);
    final newQuantity = item.quantity + delta;
    if (newQuantity < 1) {
      return;
    }
    await _repository.updateItem(item.copyWith(quantity: newQuantity));
    await loadItems();
  }
}
