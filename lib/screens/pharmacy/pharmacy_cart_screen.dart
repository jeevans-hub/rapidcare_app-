import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/cart_model.dart';
import '../../services/cart_service.dart';
import '../../widgets/pharmacy/pharmacy_widgets.dart';

class PharmacyCartScreen extends StatefulWidget {
  const PharmacyCartScreen({super.key});

  @override
  State<PharmacyCartScreen> createState() => _PharmacyCartScreenState();
}

class _PharmacyCartScreenState extends State<PharmacyCartScreen> {
  Cart? _cart;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCart();
  }

  Future<void> _fetchCart() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await CartService.getCart();
      
      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        setState(() {
          _cart = Cart.fromJson(data['cart'] as Map<String, dynamic>);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Failed to fetch cart';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Unable to connect to the server';
        _isLoading = false;
      });
    }
  }

  Future<void> _updateQuantity(String medicineId, int quantity) async {
    try {
      final result = await CartService.updateCartItem(
        medicineId: medicineId,
        quantity: quantity,
      );
      
      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        setState(() {
          _cart = Cart.fromJson(data['cart'] as Map<String, dynamic>);
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Failed to update quantity'),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to connect to the server'),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    }
  }

  Future<void> _removeItem(String medicineId) async {
    try {
      final result = await CartService.removeFromCart(medicineId);
      
      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        setState(() {
          _cart = Cart.fromJson(data['cart'] as Map<String, dynamic>);
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Failed to remove item'),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to connect to the server'),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    }
  }

  void _proceedToCheckout() {
    Navigator.pushNamed(
      context,
      AppRoutes.pharmacyOrderConfirmation,
      arguments: {'cart': _cart},
    ).then((_) => _fetchCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.errorRed),
              const SizedBox(height: AppSpacing.md),
              Text(
                _errorMessage!,
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _fetchCart,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_cart == null || _cart!.items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart_outlined, size: 64, color: AppColors.textSecondaryGrey),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Your cart is empty',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Add medicines to get started',
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondaryGrey),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchCart,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: List.generate(_cart!.items.length, (index) {
                  final item = _cart!.items[index];
                  return Padding(
 padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: MedicineCartItem(
                      name: item.medicineName,
                      price: item.priceAtAdd,
                      quantity: item.quantity,
                      onQuantityChanged: (quantity) {
                        if (quantity == 0) {
                          _removeItem(item.medicineId);
                        } else {
                          _updateQuantity(item.medicineId, quantity);
                        }
                      },
                      onRemove: () {
                        _removeItem(item.medicineId);
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
                subtotal: _cart!.subtotal,
                deliveryFee: _cart!.deliveryFee,
                discount: 0.0,
                total: _cart!.total,
                onProceedToCheckout: _proceedToCheckout,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
