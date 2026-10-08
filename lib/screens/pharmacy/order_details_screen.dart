import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/order_model.dart';
import '../../services/order_service.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Order? _order;
  bool _isLoading = true;
  String? _errorMessage;
  String? _orderId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && _orderId == null) {
      _orderId = args['orderId'] as String?;
      if (_orderId != null) {
        _fetchOrderDetails();
      }
    }
  }

  Future<void> _fetchOrderDetails() async {
    if (_orderId == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await OrderService.getOrderById(_orderId!);

      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        setState(() {
          _order = Order.fromJson(data['order'] as Map<String, dynamic>);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Failed to fetch order details';
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

  Future<void> _cancelOrder() async {
    if (_order == null || !_order!.canCancel) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text('Are you sure you want to cancel this order?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Yes',
              style: TextStyle(color: AppColors.errorRed),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await OrderService.cancelOrder(_order!.id);

      if (result['success'] == true) {
        final data = result['data'] as Map<String, dynamic>;
        setState(() {
          _order = Order.fromJson(data['order'] as Map<String, dynamic>);
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Order cancelled successfully'),
              backgroundColor: AppColors.successGreen,
            ),
          );
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Failed to cancel order'),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
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
                onPressed: _fetchOrderDetails,
                child: const Text('Retry'),
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
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OrderHeader(order: _order!),
            const SizedBox(height: AppSpacing.lg),
            _OrderItemsCard(order: _order!),
            const SizedBox(height: AppSpacing.lg),
            _OrderSummaryCard(order: _order!),
            const SizedBox(height: AppSpacing.lg),
            _OrderInfoCard(order: _order!),
            const SizedBox(height: AppSpacing.lg),
            if (_order!.canCancel)
              ElevatedButton(
                onPressed: _cancelOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.errorRed,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Cancel Order'),
              ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _OrderHeader extends StatelessWidget {
  final Order order;

  const _OrderHeader({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                Expanded(
                  child: Text(
                    'Order #${order.id.substring(0, 8).toUpperCase()}',
                    style: AppTextStyles.headline.copyWith(fontSize: 20),
                  ),
                ),
                _StatusBadge(status: order.status),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Placed on ${_formatDate(order.createdAt)}',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondaryGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _OrderItemsCard extends StatelessWidget {
  final Order order;

  const _OrderItemsCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Items', style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.md),
            ...order.items.map((item) => _OrderItemRow(item: item)),
          ],
        ),
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final OrderItem item;

  const _OrderItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.nameSnapshot, style: AppTextStyles.body),
                const SizedBox(height: 2),
                Text(
                  'Qty: ${item.quantity}',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryGrey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${item.total.toStringAsFixed(2)}',
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  final Order order;

  const _OrderSummaryCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Summary', style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.md),
            _SummaryRow(
              label: 'Subtotal',
              value: '\$${order.subtotal.toStringAsFixed(2)}',
            ),
            const SizedBox(height: AppSpacing.sm),
            _SummaryRow(
              label: 'Delivery Fee',
              value: '\$${order.deliveryFee.toStringAsFixed(2)}',
            ),
            const Divider(height: AppSpacing.lg),
            _SummaryRow(
              label: 'Total',
              value: '\$${order.totalAmount.toStringAsFixed(2)}',
              valueStyle: AppTextStyles.title.copyWith(
                color: AppColors.primaryBlue,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            color: AppColors.textSecondaryGrey,
          ),
        ),
        Text(value, style: valueStyle ?? AppTextStyles.body),
      ],
    );
  }
}

class _OrderInfoCard extends StatelessWidget {
  final Order order;

  const _OrderInfoCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Information', style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.md),
            _InfoRow(
              label: 'Payment Method',
              value: order.paymentMethod.replaceAll('_', ' ').toUpperCase(),
            ),
            if (order.deliveryAddress != null) ...[
              const SizedBox(height: AppSpacing.sm),
              _InfoRow(
                label: 'Delivery Address',
                value: order.deliveryAddress!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondaryGrey,
          ),
        ),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyles.body),
      ],
    );
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
        backgroundColor = AppColors.warningOrange.withValues(alpha: 0.2);
        textColor = AppColors.warningOrange;
        displayText = 'Placed';
        break;
      case 'confirmed':
        backgroundColor = AppColors.primaryBlue.withValues(alpha: 0.2);
        textColor = AppColors.primaryBlue;
        displayText = 'Confirmed';
        break;
      case 'packed':
        backgroundColor = AppColors.primaryBlue.withValues(alpha: 0.2);
        textColor = AppColors.primaryBlue;
        displayText = 'Packed';
        break;
      case 'out_for_delivery':
        backgroundColor = AppColors.primaryBlue.withValues(alpha: 0.2);
        textColor = AppColors.primaryBlue;
        displayText = 'Out for Delivery';
        break;
      case 'delivered':
        backgroundColor = AppColors.successGreen.withValues(alpha: 0.2);
        textColor = AppColors.successGreen;
        displayText = 'Delivered';
        break;
      case 'cancelled':
        backgroundColor = AppColors.errorRed.withValues(alpha: 0.2);
        textColor = AppColors.errorRed;
        displayText = 'Cancelled';
        break;
      default:
        backgroundColor = AppColors.textSecondaryGrey.withValues(alpha: 0.2);
        textColor = AppColors.textSecondaryGrey;
        displayText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
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
