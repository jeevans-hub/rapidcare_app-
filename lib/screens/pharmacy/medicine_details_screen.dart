import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/medicine_model.dart';
import '../../services/medicine_service.dart';
import '../../services/cart_service.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';

class MedicineDetailsScreen extends StatefulWidget {
  const MedicineDetailsScreen({super.key});

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  Medicine? _medicine;
  bool _isLoading = true;
  String? _errorMessage;
  String? _medicineId;
  int _quantity = 1;
  bool _isAddingToCart = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && _medicineId == null) {
      _medicineId = args['medicineId'] as String?;
      if (_medicineId != null) {
        _fetchMedicineDetails();
      } else {
        _isLoading = false;
        _errorMessage = 'Medicine was not selected';
      }
    } else if (args == null && _medicineId == null) {
      _isLoading = false;
      _errorMessage = 'Medicine was not selected';
    }
  }

  Future<void> _fetchMedicineDetails() async {
    if (_medicineId == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await MedicineService.getMedicineById(_medicineId!);

      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        setState(() {
          _medicine = Medicine.fromJson(
            data['medicine'] as Map<String, dynamic>,
          );
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage =
              result['message'] ?? 'Failed to fetch medicine details';
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

  Future<bool> _addToCart() async {
    if (_medicine == null || _isAddingToCart) return false;

    setState(() {
      _isAddingToCart = true;
    });

    try {
      final result = await CartService.addToCart(
        medicineId: _medicine!.id,
        quantity: _quantity,
      );

      if (result['success'] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to cart'),
              backgroundColor: AppColors.successGreen,
              duration: Duration(seconds: 1),
            ),
          );
        }
        return true;
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Failed to add to cart'),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
        return false;
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
      return false;
    } finally {
      if (mounted) {
        setState(() {
          _isAddingToCart = false;
        });
      }
    }
  }

  void _buyNow() {
    _addToCart().then((added) {
      if (added && mounted) {
        Navigator.pushNamed(context, AppRoutes.pharmacyCart);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Details')),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.errorRed,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                _errorMessage!,
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _fetchMedicineDetails,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_medicine == null) {
      return const Center(child: Text('Medicine not found'));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.backgroundLightGrey,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppRadius.large),
                bottomRight: Radius.circular(AppRadius.large),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.medication,
                size: 100,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _medicine!.name,
                        style: AppTextStyles.headline.copyWith(fontSize: 24),
                      ),
                    ),
                    if (_medicine!.discountText.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.errorRed,
                          borderRadius: BorderRadius.circular(AppRadius.small),
                        ),
                        child: Text(
                          _medicine!.discountText,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _medicine!.category,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryGrey,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 20,
                      color: AppColors.warningOrange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _medicine!.rating.toString(),
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      '(${_medicine!.reviewCount} reviews)',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Text(
                      '\$${_medicine!.discountedPrice.toStringAsFixed(2)}',
                      style: AppTextStyles.headline.copyWith(
                        color: AppColors.primaryBlue,
                        fontSize: 28,
                      ),
                    ),
                    if (_medicine!.mrp != null &&
                        _medicine!.mrp! > _medicine!.price) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '\$${_medicine!.mrp!.toStringAsFixed(2)}',
                        style: AppTextStyles.title.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.textSecondaryGrey,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                if (_medicine!.requiresPrescription)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.warningOrange.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(AppRadius.small),
                      border: Border.all(color: AppColors.warningOrange),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning,
                          color: AppColors.warningOrange,
                          size: 16,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'Prescription Required',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.warningOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (_medicine!.requiresPrescription)
                  const SizedBox(height: AppSpacing.lg),
                if (_medicine!.description != null &&
                    _medicine!.description!.isNotEmpty) ...[
                  const SectionTitle(title: 'Description'),
                  const SizedBox(height: AppSpacing.sm),
                  Text(_medicine!.description!, style: AppTextStyles.body),
                  const SizedBox(height: AppSpacing.lg),
                ],
                const SectionTitle(title: 'Safety Information'),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLightGrey,
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                  ),
                  child: Text(
                    'Consult a qualified medical professional before using any medicine.',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondaryGrey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(title: 'Quantity'),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    IconButton(
                      onPressed: _quantity > 1
                          ? () => setState(() => _quantity--)
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text('$_quantity', style: AppTextStyles.title),
                    IconButton(
                      onPressed: _quantity < (_medicine!.stock)
                          ? () => setState(() => _quantity++)
                          : null,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    if (!_medicine!.isQuantityAvailable(_quantity))
                      Text(
                        'Only ${_medicine!.stock} available',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.errorRed,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed:
                            _isAddingToCart ||
                                !_medicine!.isQuantityAvailable(_quantity)
                            ? null
                            : _addToCart,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppRadius.medium,
                            ),
                          ),
                        ),
                        child: _isAddingToCart
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Add to Cart'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: PrimaryButton(
                        text: 'Buy Now',
                        onPressed:
                            _isAddingToCart ||
                                !_medicine!.isQuantityAvailable(_quantity)
                            ? null
                            : () => _buyNow(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
