import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/medicine_model.dart';
import '../../services/medicine_service.dart';
import '../../services/cart_service.dart';
import '../../widgets/pharmacy/pharmacy_widgets.dart';

class PharmacyHomeScreen extends StatefulWidget {
  const PharmacyHomeScreen({super.key});

  @override
  State<PharmacyHomeScreen> createState() => _PharmacyHomeScreenState();
}

class _PharmacyHomeScreenState extends State<PharmacyHomeScreen> {
  List<Medicine> _medicines = [];
  bool _isLoading = true;
  String? _errorMessage;
  int _cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchMedicines();
    _fetchCartCount();
  }

  Future<void> _fetchMedicines() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await MedicineService.getMedicines();
      
      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        final medicinesList = data['medicines'] as List<dynamic>? ?? [];
        setState(() {
          _medicines = medicinesList.map((json) => Medicine.fromJson(json as Map<String, dynamic>)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Failed to fetch medicines';
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

  Future<void> _fetchCartCount() async {
    try {
      final result = await CartService.getCart();
      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        final cartData = data['cart'] as Map<String, dynamic>?;
        if (cartData != null) {
          final items = cartData['items'] as List<dynamic>? ?? [];
          setState(() {
            _cartItemCount = items.fold(0, (sum, item) => sum + (item['quantity'] as int? ?? 1));
          });
        }
      }
    } catch (e) {
      // Silently fail for cart count
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.orderHistory);
            },
            tooltip: 'Order history',
            icon: const Icon(Icons.receipt_long_outlined),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.pharmacyCart).then((_) => _fetchCartCount());
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              if (_cartItemCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      _cartItemCount > 99 ? '99+' : '$_cartItemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
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
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _fetchMedicines,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_medicines.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.medication_outlined, size: 64, color: AppColors.textSecondaryGrey),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'No medicines available',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchMedicines,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.md),
            PharmacyHeader(
              title: 'Order Medicines',
              subtitle: 'Medicines delivered to your doorstep',
              cartItemCount: _cartItemCount,
            ),
            const SizedBox(height: AppSpacing.md),
            MedicineSearchBar(
              onChanged: (value) {
                // TODO: Implement search
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            const MedicineCategoriesSection(),
            const SizedBox(height: AppSpacing.lg),
            MedicineList(
              title: 'Popular Medicines',
              children: _medicines.take(6).map((medicine) {
                return MedicineCard(
                  name: medicine.name,
                  category: medicine.category,
                  price: medicine.price,
                  originalPrice: medicine.mrp,
                  rating: medicine.rating,
                  discount: medicine.discountText.isNotEmpty ? medicine.discountText : null,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.medicineDetails,
                      arguments: {'medicineId': medicine.id},
                    ).then((_) => _fetchCartCount());
                  },
                  onAddTap: () {
                    _addToCart(medicine.id);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Future<void> _addToCart(String medicineId) async {
    try {
      final result = await CartService.addToCart(medicineId: medicineId);
      if (result['success'] == true) {
        setState(() {
          _cartItemCount++;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to cart'),
              backgroundColor: AppColors.successGreen,
              duration: Duration(seconds: 1),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Failed to add to cart'),
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
}
