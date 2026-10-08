import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/order_model.dart';
import '../../services/order_service.dart';
import '../../widgets/primary_button.dart';

class PharmacyOrderConfirmationScreen extends StatefulWidget {
  const PharmacyOrderConfirmationScreen({super.key});

  @override
  State<PharmacyOrderConfirmationScreen> createState() =>
      _PharmacyOrderConfirmationScreenState();
}

class _PharmacyOrderConfirmationScreenState
    extends State<PharmacyOrderConfirmationScreen> {
  Order? _order;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isPlacingOrder = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && _order == null && !_isPlacingOrder) {
      _placeOrder();
    }
  }

  Future<void> _placeOrder() async {
    setState(() {
      _isPlacingOrder = true;
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await OrderService.placeOrder();

      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        setState(() {
          _order = Order.fromJson(data['order'] as Map<String, dynamic>);
          _isLoading = false;
          _isPlacingOrder = false;
        });
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Failed to place order';
          _isLoading = false;
          _isPlacingOrder = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Unable to connect to the server';
        _isLoading = false;
        _isPlacingOrder = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Confirmation')),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: AppSpacing.md),
            Text('Placing your order...'),
          ],
        ),
      );
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
                onPressed: _placeOrder,
                child: const Text('Retry'),
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Cart'),
              ),
            ],
          ),
        ),
      );
    }

    if (_order == null) {
      return const Center(child: Text('Order not found'));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xl),
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.successGreen.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 80,
                color: AppColors.successGreen,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const Center(
            child: Text(
              'Order Placed Successfully!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.successGreen,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Center(
            child: Text(
              'Your order has been placed successfully',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondaryGrey,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _OrderDetailCard(order: _order!),
          const SizedBox(height: AppSpacing.xl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.orderDetails,
                        arguments: {'orderId': _order!.id},
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.medium),
                      ),
                    ),
                    child: const Text('View Order Details'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: PrimaryButton(
                    text: 'Back to Home',
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _OrderDetailCard extends StatelessWidget {
  final Order order;

  const _OrderDetailCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow(
              label: 'Order ID',
              value: '#${order.id.substring(0, 8).toUpperCase()}',
            ),
            const SizedBox(height: AppSpacing.sm),
            _DetailRow(label: 'Estimated Delivery', value: '2-3 business days'),
            if (order.deliveryAddress != null) ...[
              const SizedBox(height: AppSpacing.sm),
              _DetailRow(
                label: 'Delivery Address',
                value: order.deliveryAddress!,
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            const Divider(),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Ordered Items:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...order.items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Text(
                  '${item.nameSnapshot} x ${item.quantity}',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Divider(),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${order.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondaryGrey,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
