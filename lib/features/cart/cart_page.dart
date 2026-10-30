import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<_CartItem> _items = [
    const _CartItem(
      name: 'Complete Blood Count (CBC)',
      type: 'Blood Test',
      price: 349,
      icon: Icons.water_drop_outlined,
    ),
    const _CartItem(
      name: 'Thyroid Profile (T3, T4, TSH)',
      type: 'Blood Test',
      price: 599,
      icon: Icons.water_drop_outlined,
    ),
  ];

  static const int _discount = 50;

  int get _subtotal => _items.fold(0, (sum, item) => sum + item.price);
  int get _total => _items.isEmpty ? 0 : (_subtotal - _discount > 0 ? _subtotal - _discount : 0);

  void _removeItem(int index) {
    final removed = _items[index];
    setState(() {
      _items.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removed.name} removed from cart'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          textColor: AppColors.amber,
          onPressed: () {
            setState(() {
              _items.insert(index, removed);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header: 'Cart' + item count ──
            _buildHeader(),

            // ── Body ──
            Expanded(
              child: _items.isEmpty
                  ? _buildEmptyState()
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),

                          // ── Cart Items List ──
                          ...List.generate(
                            _items.length,
                            (index) => _buildCartItemCard(_items[index], index),
                          ),

                          const SizedBox(height: 12),

                          // ── Price Summary ──
                          _buildPriceSummary(),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),

      // ── Sticky bottom bar: Total + 'Proceed to Book' teal button ──
      bottomNavigationBar: _items.isNotEmpty ? _buildStickyBottomBar() : null,
    );
  }

  // ── Header ─────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          const Text(
            'Cart',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          if (_items.isNotEmpty) ...[
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.iconBgTeal,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_items.length} ${_items.length == 1 ? 'item' : 'items'}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Cart Item Card ─────────────────────────────────────────

  Widget _buildCartItemCard(_CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon circle
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: AppColors.iconBgTeal,
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),

          // Name, Type, Price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.type,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '₹${item.price}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // Delete button
          IconButton(
            onPressed: () => _removeItem(index),
            icon: const Icon(
              Icons.delete_outline,
              color: Color(0xFFD32F2F),
              size: 22,
            ),
            tooltip: 'Remove test',
          ),
        ],
      ),
    );
  }

  // ── Price Summary ──────────────────────────────────────────

  Widget _buildPriceSummary() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),

          // Subtotal
          _buildSummaryRow(
            label: 'Subtotal',
            value: '₹$_subtotal',
          ),
          const SizedBox(height: 10),

          // Discount
          _buildSummaryRow(
            label: 'Discount',
            value: '-₹$_discount',
            valueColor: AppColors.primary,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: AppColors.borderLight),
          ),

          // Total
          _buildSummaryRow(
            label: 'Total',
            value: '₹$_total',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
    Color? valueColor,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  // ── Sticky Bottom Bar ──────────────────────────────────────

  Widget _buildStickyBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        border: const Border(
          top: BorderSide(color: AppColors.borderLight, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '₹$_total',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Proceeding to booking...'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Proceed to Book',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Empty State ────────────────────────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: AppColors.iconBgTeal,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 46,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore our wide range of lab tests\nand health packages.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Browse Tests',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItem {
  final String name;
  final String type;
  final int price;
  final IconData icon;

  const _CartItem({
    required this.name,
    required this.type,
    required this.price,
    required this.icon,
  });
}
