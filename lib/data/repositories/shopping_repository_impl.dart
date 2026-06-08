import '../../domain/entities/shopping_item.dart';
import '../../domain/repositories/shopping_repository.dart';
import '../datasources/shopping_local_datasource.dart';
import '../models/shopping_item_model.dart';

class ShoppingRepositoryImpl implements ShoppingRepository {
  ShoppingRepositoryImpl(this._datasource);

  final ShoppingLocalDatasource _datasource;

  @override
  Future<List<ShoppingItem>> getItems() async {
    return _datasource.getItems().map((item) => item.toEntity()).toList();
  }

  @override
  Future<void> saveItems(List<ShoppingItem> items) async {
    final models = items.map(ShoppingItemModel.fromEntity).toList();
    await _datasource.saveItems(models);
  }

  @override
  Future<void> addItem(ShoppingItem item) async {
    final items = await getItems();
    items.add(item);
    await saveItems(items);
  }

  @override
  Future<void> updateItem(ShoppingItem item) async {
    final items = await getItems();
    final index = items.indexWhere((existing) => existing.id == item.id);
    if (index == -1) {
      return;
    }
    items[index] = item;
    await saveItems(items);
  }

  @override
  Future<void> deleteItem(String id) async {
    final items = await getItems();
    items.removeWhere((item) => item.id == id);
    await saveItems(items);
  }
}
