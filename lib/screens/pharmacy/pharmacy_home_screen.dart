import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/pharmacy/pharmacy_widgets.dart';

class PharmacyHomeScreen extends StatelessWidget {
  const PharmacyHomeScreen({super.key});

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
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.pharmacyCart);
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
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
                  child: const Text(
                    '2',
                    style: TextStyle(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              const PharmacyHeader(
                title: 'Order Medicines',
                subtitle: 'Medicines delivered to your doorstep',
                cartItemCount: 2,
              ),
              const SizedBox(height: AppSpacing.md),
              const MedicineSearchBar(),
              const SizedBox(height: AppSpacing.lg),
              const MedicineCategoriesSection(),
              const SizedBox(height: AppSpacing.lg),
              MedicineList(
                title: 'Popular Medicines',
                children: [
                  MedicineCard(
                    name: 'Paracetamol 500mg',
                    category: 'Pain Relief',
                    price: 5.99,
                    originalPrice: 7.99,
                    rating: 4.5,
                    discount: '25% OFF',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.medicineDetails);
                    },
                  ),
                  MedicineCard(
                    name: 'Vitamin C 1000mg',
                    category: 'Vitamins',
                    price: 12.99,
                    originalPrice: 15.99,
                    rating: 4.8,
                    discount: '18% OFF',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.medicineDetails);
                    },
                  ),
                  MedicineCard(
                    name: 'Cough Syrup',
                    category: 'Cold & Flu',
                    price: 8.49,
                    rating: 4.3,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.medicineDetails);
                    },
                  ),
                  MedicineCard(
                    name: 'Antiseptic Cream',
                    category: 'First Aid',
                    price: 6.99,
                    originalPrice: 8.99,
                    rating: 4.6,
                    discount: '22% OFF',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.medicineDetails);
                    },
                  ),
                  MedicineCard(
                    name: 'Bandage Pack',
                    category: 'First Aid',
                    price: 4.99,
                    rating: 4.4,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.medicineDetails);
                    },
                  ),
                  MedicineCard(
                    name: 'Thermometer',
                    category: 'Health Devices',
                    price: 15.99,
                    originalPrice: 19.99,
                    rating: 4.7,
                    discount: '20% OFF',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.medicineDetails);
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
