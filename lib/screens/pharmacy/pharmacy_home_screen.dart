import 'dart:async';
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
  List<String> _categories = [];
  String? _category;
  bool _availableOnly = false;
  final _search = TextEditingController();
  Timer? _debounce;
  int _request = 0;
  final Set<String> _adding = {};
  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  void _reset() {
    _search.clear();
    _category = null;
    _availableOnly = false;
    _fetchMedicines();
  }

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
    if (!mounted) return;
    final request = ++_request;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await MedicineService.getMedicines(
        search: _search.text.trim(),
        category: _category,
        available: _availableOnly ? true : null,
      );
      if (!mounted || request != _request) return;

      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        _categories = (data['categories'] as List<dynamic>? ?? [])
            .cast<String>();
        final medicinesList = data['medicines'] as List<dynamic>? ?? [];
        setState(() {
          _medicines = medicinesList
              .map((json) => Medicine.fromJson(json as Map<String, dynamic>))
              .toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Failed to fetch medicines';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted || request != _request) return;
      setState(() {
        _errorMessage = 'Unable to connect to the server';
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchCartCount() async {
    try {
      final result = await CartService.getCart();
      if (!mounted) return;
      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        final cartData = data['cart'] as Map<String, dynamic>?;
        if (cartData != null) {
          final items = cartData['items'] as List<dynamic>? ?? [];
          setState(() {
            _cartItemCount = items.fold(
              0,
              (sum, item) => sum + (item['quantity'] as int? ?? 1),
            );
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
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.notifications),
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
                  Navigator.pushNamed(
                    context,
                    AppRoutes.pharmacyCart,
                  ).then((_) => _fetchCartCount());
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
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: _fetchMedicines,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.md),
            PharmacyHeader(
              title: 'Order Medicines',
              subtitle: 'Demo pharmacy — no real delivery or payment',
              onCartTap: () => Navigator.pushNamed(
                context,
                AppRoutes.pharmacyCart,
              ).then((_) => _fetchCartCount()),
              onNotificationTap: () =>
                  Navigator.pushNamed(context, AppRoutes.notifications),
              cartItemCount: _cartItemCount,
            ),
            const SizedBox(height: AppSpacing.md),
            MedicineSearchBar(
              controller: _search,
              onFilterTap: () {
                setState(() => _availableOnly = !_availableOnly);
                _fetchMedicines();
              },
              onChanged: (value) {
                _debounce?.cancel();
                _debounce = Timer(
                  const Duration(milliseconds: 300),
                  _fetchMedicines,
                );
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            MedicineCategoriesSection(
              categories: _categories,
              selected: _category,
              onSelected: (value) {
                _category = value;
                _fetchMedicines();
              },
            ),
            if (_category != null || _search.text.isNotEmpty || _availableOnly)
              TextButton(
                onPressed: _reset,
                child: Text(
                  _availableOnly
                      ? 'In stock only • Reset filters'
                      : 'Reset filters',
                ),
              ),
            const SizedBox(height: AppSpacing.lg),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_errorMessage != null)
              Column(
                children: [
                  Text(_errorMessage!),
                  TextButton(
                    onPressed: _fetchMedicines,
                    child: const Text('Retry'),
                  ),
                ],
              )
            else if (_medicines.isEmpty)
              const Center(child: Text('No medicines available'))
            else
              MedicineList(
                title: 'Medicines',
                children: _medicines.map((medicine) {
                  return MedicineCard(
                    name: medicine.name,
                    category: medicine.category,
                    price: medicine.price,
                    originalPrice: medicine.mrp,
                    rating: medicine.rating,
                    discount: medicine.discountText.isNotEmpty
                        ? medicine.discountText
                        : null,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.medicineDetails,
                        arguments: {'medicineId': medicine.id},
                      ).then((_) => _fetchCartCount());
                    },
                    stock: medicine.stock,
                    available: medicine.isAvailable,
                    requiresPrescription: medicine.requiresPrescription,
                    onAddTap:
                        !medicine.isInStock || _adding.contains(medicine.id)
                        ? null
                        : () => _addToCart(medicine.id),
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
    if (!_adding.add(medicineId)) return;
    setState(() {});
    try {
      final result = await CartService.addToCart(medicineId: medicineId);
      if (result['success'] == true) {
        await _fetchCartCount();
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
    } finally {
      if (mounted) setState(() => _adding.remove(medicineId));
    }
  }
}
