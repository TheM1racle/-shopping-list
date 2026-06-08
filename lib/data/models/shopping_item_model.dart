import '../../domain/entities/shopping_item.dart';

class ShoppingItemModel {
  ShoppingItemModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.isPurchased,
  });

  final String id;
  final String name;
  final int quantity;
  final bool isPurchased;

  factory ShoppingItemModel.fromEntity(ShoppingItem entity) {
    return ShoppingItemModel(
      id: entity.id,
      name: entity.name,
      quantity: entity.quantity,
      isPurchased: entity.isPurchased,
    );
  }

  ShoppingItem toEntity() {
    return ShoppingItem(
      id: id,
      name: name,
      quantity: quantity,
      isPurchased: isPurchased,
    );
  }

  factory ShoppingItemModel.fromMap(Map<dynamic, dynamic> map) {
    return ShoppingItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      isPurchased: map['isPurchased'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'isPurchased': isPurchased,
    };
  }
}
