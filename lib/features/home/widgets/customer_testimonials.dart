import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class CustomerTestimonials extends StatelessWidget {
  const CustomerTestimonials({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What customers say',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          _TestimonialCard(
            name: '[Customer name]',
            message:
                '[Customer feedback message goes here, with an optional photo.]',
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String name;
  final String message;

  const _TestimonialCard({
    required this.name,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Avatar ──
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.iconBgTeal,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.person_outline,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),

          // ── Text content ──
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
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
