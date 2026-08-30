class Medicine {
  final String id;
  final String name;
  final String? genericName;
  final String? brand;
  final String category;
  final String? description;
  final double price;
  final double? mrp;
  final double discountPercent;
  final int stock;
  final String unit;
  final bool requiresPrescription;
  final String? manufacturer;
  final String? expiryInfo;
  final String? imageUrl;
  final bool isAvailable;
  final double rating;
  final int reviewCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Medicine({
    required this.id,
    required this.name,
    this.genericName,
    this.brand,
    required this.category,
    this.description,
    required this.price,
    this.mrp,
    this.discountPercent = 0,
    required this.stock,
    required this.unit,
    this.requiresPrescription = false,
    this.manufacturer,
    this.expiryInfo,
    this.imageUrl,
    this.isAvailable = true,
    this.rating = 4.5,
    this.reviewCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      genericName: json['genericName'],
      brand: json['brand'],
      category: json['category'] ?? 'General',
      description: json['description'],
      price: (json['price'] ?? 0).toDouble(),
      mrp: json['mrp']?.toDouble(),
      discountPercent: (json['discountPercent'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      unit: json['unit'] ?? 'tablet',
      requiresPrescription: json['requiresPrescription'] ?? false,
      manufacturer: json['manufacturer'],
      expiryInfo: json['expiryInfo'],
      imageUrl: json['imageUrl'],
      isAvailable: json['isAvailable'] ?? true,
      rating: (json['rating'] ?? 4.5).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'genericName': genericName,
      'brand': brand,
      'category': category,
      'description': description,
      'price': price,
      'mrp': mrp,
      'discountPercent': discountPercent,
      'stock': stock,
      'unit': unit,
      'requiresPrescription': requiresPrescription,
      'manufacturer': manufacturer,
      'expiryInfo': expiryInfo,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'rating': rating,
      'reviewCount': reviewCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Helper methods for display
  double get discountedPrice {
    // `price` is the already-discounted selling price returned by the API.
    // `discountPercent` is used for the promotional badge only.
    return price;
  }

  String get discountText {
    if (discountPercent > 0) {
      return '${discountPercent.toInt()}% OFF';
    }
    return '';
  }

  bool get isInStock => stock > 0 && isAvailable;

  bool isQuantityAvailable(int quantity) => stock >= quantity && isAvailable;
}
