class ShoppingItem {
  const ShoppingItem({
    required this.id,
    required this.name,
    required this.quantity,
    this.isPurchased = false,
  });

  final String id;
  final String name;
  final int quantity;
  final bool isPurchased;

  ShoppingItem copyWith({
    String? id,
    String? name,
    int? quantity,
    bool? isPurchased,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      isPurchased: isPurchased ?? this.isPurchased,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShoppingItem &&
          id == other.id &&
          name == other.name &&
          quantity == other.quantity &&
          isPurchased == other.isPurchased;

  @override
  int get hashCode => Object.hash(id, name, quantity, isPurchased);
}
