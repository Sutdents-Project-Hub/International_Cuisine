class ShoppingList {
  final String id;
  final String title;
  final List<ShoppingListItem> items;
  final DateTime createdAt;

  ShoppingList({
    required this.id,
    required this.title,
    required this.items,
    required this.createdAt,
  });

  factory ShoppingList.fromJson(Map<String, dynamic> json) {
    return ShoppingList(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Shopping List',
      items: ((json['items'] as List?) ?? const [])
          .map((e) {
            if (e is Map<String, dynamic>) return ShoppingListItem.fromJson(e);
            if (e is Map) {
              return ShoppingListItem.fromJson(
                e.map((key, value) => MapEntry(key.toString(), value)),
              );
            }
            return ShoppingListItem(
              id: '',
              ingredientName: e.toString(),
              quantity: 0,
              unit: '',
              checked: false,
              category: 'OTHER',
            );
          })
          .toList(growable: false),
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}

class ShoppingListItem {
  final String id;
  final String ingredientName;
  final double quantity;
  final String unit;
  final bool checked;
  final String category;

  ShoppingListItem({
    required this.id,
    required this.ingredientName,
    required this.quantity,
    required this.unit,
    required this.checked,
    required this.category,
  });

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) {
    return ShoppingListItem(
      id: json['id']?.toString() ?? '',
      ingredientName: json['ingredientName']?.toString() ?? 'Unknown Item',
      quantity:
          (json['totalQty'] as num?)?.toDouble() ??
          (json['quantity'] as num?)?.toDouble() ??
          0,
      unit: json['unit']?.toString() ?? '',
      checked: json['checked'] as bool? ?? false,
      category: json['category']?.toString() ?? 'OTHER',
    );
  }
}
