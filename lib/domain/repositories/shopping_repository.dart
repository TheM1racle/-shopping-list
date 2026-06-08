import '../entities/shopping_item.dart';

abstract class ShoppingRepository {
  Future<List<ShoppingItem>> getItems();

  Future<void> saveItems(List<ShoppingItem> items);

  Future<void> addItem(ShoppingItem item);

  Future<void> updateItem(ShoppingItem item);

  Future<void> deleteItem(String id);
}
