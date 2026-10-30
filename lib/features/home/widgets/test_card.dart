import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class TestCard extends StatelessWidget {
  final String name;
  final String tag;
  final String price;
  final VoidCallback? onBook;

  const TestCard({
    super.key,
    required this.name,
    required this.tag,
    required this.price,
    this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          // ── Icon ──
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.iconBgTeal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.water_drop_outlined,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),

          // ── Info ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // ── Book button ──
          SizedBox(
            height: 42,
            child: ElevatedButton(
              onPressed: onBook ?? () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 22),
                elevation: 0,
              ),
              child: const Text(
                'Book',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
