import '../models/shopping_item_model.dart';
import 'local_storage.dart';

class ShoppingLocalDatasource {
  ShoppingLocalDatasource(this._storage);

  final LocalStorage _storage;

  List<ShoppingItemModel> getItems() {
    final raw = _storage.shoppingBox.get(LocalStorage.itemsKey);
    if (raw is! List) {
      return [];
    }
    return raw
        .whereType<Map>()
        .map((item) => ShoppingItemModel.fromMap(item))
        .toList();
  }

  Future<void> saveItems(List<ShoppingItemModel> items) async {
    await _storage.shoppingBox.put(
      LocalStorage.itemsKey,
      items.map((item) => item.toMap()).toList(),
    );
  }
}
