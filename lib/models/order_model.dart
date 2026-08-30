import 'medicine_model.dart';

class OrderItem {
  final String medicineId;
  final String nameSnapshot;
  final double priceSnapshot;
  final int quantity;
  final Medicine? medicine;

  OrderItem({
    required this.medicineId,
    required this.nameSnapshot,
    required this.priceSnapshot,
    required this.quantity,
    this.medicine,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      medicineId: json['medicine']?['_id']?.toString() ?? json['medicine']?.toString() ?? '',
      nameSnapshot: json['nameSnapshot'] ?? '',
      priceSnapshot: (json['priceSnapshot'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      medicine: json['medicine'] != null ? Medicine.fromJson(json['medicine']) : null,
    );
  }

  double get total => priceSnapshot * quantity;
}

class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double totalAmount;
  final String status;
  final String? deliveryAddress;
  final String paymentMethod;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.totalAmount,
    required this.status,
    this.deliveryAddress,
    required this.paymentMethod,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>? ?? [];
    final items = itemsList.map((item) => OrderItem.fromJson(item as Map<String, dynamic>)).toList();

    return Order(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      userId: json['user']?.toString() ?? '',
      items: items,
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: json['status'] ?? 'placed',
      deliveryAddress: json['deliveryAddress'],
      paymentMethod: json['paymentMethod'] ?? 'cash_on_delivery',
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  String get statusDisplay {
    switch (status) {
      case 'placed':
        return 'Placed';
      case 'confirmed':
        return 'Confirmed';
      case 'packed':
        return 'Packed';
      case 'out_for_delivery':
        return 'Out for Delivery';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  bool get canCancel => status == 'placed' || status == 'confirmed';
  bool get isCancelled => status == 'cancelled';
  bool get isDelivered => status == 'delivered';

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}
