import 'medicine_model.dart';

class CartItem {
  final String medicineId;
  final String medicineName;
  final int quantity;
  final double priceAtAdd;
  final Medicine? medicine;

  CartItem({
    required this.medicineId,
    required this.medicineName,
    required this.quantity,
    required this.priceAtAdd,
    this.medicine,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      medicineId: json['medicine']?['_id']?.toString() ?? json['medicine']?.toString() ?? '',
      medicineName: json['nameSnapshot'] ?? json['medicine']?['name'] ?? '',
      quantity: json['quantity'] ?? 1,
      priceAtAdd: (json['priceAtAdd'] ?? 0).toDouble(),
      medicine: json['medicine'] != null ? Medicine.fromJson(json['medicine']) : null,
    );
  }

  double get total => priceAtAdd * quantity;
}

class Cart {
  final String id;
  final String userId;
  final List<CartItem> items;
  final DateTime createdAt;
  final DateTime updatedAt;

  Cart({
    required this.id,
    required this.userId,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>? ?? [];
    final items = itemsList.map((item) => CartItem.fromJson(item as Map<String, dynamic>)).toList();

    return Cart(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      userId: json['user']?.toString() ?? '',
      items: items,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  double get subtotal {
    return items.fold(0, (sum, item) => sum + item.total);
  }

  double get deliveryFee => 2.99;
  double get total => subtotal + deliveryFee;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}
