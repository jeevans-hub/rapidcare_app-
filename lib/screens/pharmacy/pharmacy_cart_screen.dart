import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/pharmacy/pharmacy_widgets.dart';

class PharmacyCartScreen extends StatefulWidget {
  const PharmacyCartScreen({super.key});

  @override
  State<PharmacyCartScreen> createState() => _PharmacyCartScreenState();
}

class _PharmacyCartScreenState extends State<PharmacyCartScreen> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Paracetamol 500mg',
      'price': 5.99,
      'quantity': 2,
    },
    {
      'name': 'Vitamin C 1000mg',
      'price': 12.99,
      'quantity': 1,
    },
  ];

  double get _subtotal {
    return _cartItems.fold(
      0,
      (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int),
    );
  }

  double get _deliveryFee => 2.99;
  double get _discount => 0.0;
  double get _total => _subtotal + _deliveryFee - _discount;

  void _updateQuantity(int index, int quantity) {
    setState(() {
      _cartItems[index]['quantity'] = quantity;
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              if (_cartItems.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.shopping_cart_outlined, size: 64),
                        SizedBox(height: AppSpacing.md),
                        Text('Your cart is empty'),
                      ],
                    ),
                  ),
                )
              else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Column(
                    children: List.generate(_cartItems.length, (index) {
                      final item = _cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: MedicineCartItem(
                          name: item['name'] as String,
                          price: item['price'] as double,
                          quantity: item['quantity'] as int,
                          onQuantityChanged: (quantity) {
                            _updateQuantity(index, quantity);
                          },
                          onRemove: () {
                            _removeItem(index);
                          },
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: PharmacyCartSummary(
                    subtotal: _subtotal,
                    deliveryFee: _deliveryFee,
                    discount: _discount,
                    total: _total,
                    onProceedToCheckout: () {
                      Navigator.pushNamed(context, AppRoutes.prescription);
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
