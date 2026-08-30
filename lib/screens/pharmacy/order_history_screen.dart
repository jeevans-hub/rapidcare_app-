import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/order_model.dart';
import '../../services/order_service.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<Order> _orders = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await OrderService.getOrders();
      
      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        final ordersList = data['orders'] as List<dynamic>? ?? [];
        setState(() {
          _orders = ordersList.map((json) => Order.fromJson(json as Map<String, dynamic>)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Failed to fetch orders';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
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
                onPressed: _fetchOrders,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_orders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_bag_outlined, size: 64, color: AppColors.textSecondaryGrey),
              const SizedBox(height: AppSpacing.md),
              Text(
                'No orders yet',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Start shopping to see your orders here',
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondaryGrey),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchOrders,
      child: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: _orders.length,
        separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final order = _orders[index];
          return _OrderCard(
            order: order,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.orderDetails,
                arguments: {'orderId': order.id},
              );
            },
          );
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const _OrderCard({
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.large),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order.id.substring(0, 8).toUpperCase()}',
                    style: AppTextStyles.title,
                  ),
                  _StatusBadge(status: order.status),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${order.itemCount} item${order.itemCount > 1 ? 's' : ''}',
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondaryGrey),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '\$${order.totalAmount.toStringAsFixed(2)}',
                style: AppTextStyles.headline.copyWith(
                  color: AppColors.primaryBlue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                _formatDate(order.createdAt),
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondaryGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (status) {
      case 'placed':
        backgroundColor = AppColors.warningOrange.withOpacity(0.2);
        textColor = AppColors.warningOrange;
        displayText = 'Placed';
        break;
      case 'confirmed':
        backgroundColor = AppColors.primaryBlue.withOpacity(0.2);
        textColor = AppColors.primaryBlue;
        displayText = 'Confirmed';
        break;
      case 'packed':
        backgroundColor = AppColors.primaryBlue.withOpacity(0.2);
        textColor = AppColors.primaryBlue;
        displayText = 'Packed';
        break;
      case 'out_for_delivery':
        backgroundColor = AppColors.primaryBlue.withOpacity(0.2);
        textColor = AppColors.primaryBlue;
        displayText = 'Out for Delivery';
        break;
      case 'delivered':
        backgroundColor = AppColors.successGreen.withOpacity(0.2);
        textColor = AppColors.successGreen;
        displayText = 'Delivered';
        break;
      case 'cancelled':
        backgroundColor = AppColors.errorRed.withOpacity(0.2);
        textColor = AppColors.errorRed;
        displayText = 'Cancelled';
        break;
      default:
        backgroundColor = AppColors.textSecondaryGrey.withOpacity(0.2);
        textColor = AppColors.textSecondaryGrey;
        displayText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: Text(
        displayText,
        style: AppTextStyles.caption.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
