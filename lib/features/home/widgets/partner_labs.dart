import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PartnerLabs extends StatelessWidget {
  const PartnerLabs({super.key});

  static const _partners = [
    'Lab logo',
    'Lab logo',
    'Scan center logo',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Partner labs & centers',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _partners.map((name) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _PartnerChip(label: name),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PartnerChip extends StatelessWidget {
  final String label;
  const _PartnerChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.textHint.withValues(alpha: 0.45),
          width: 1.5,
          // Dashed border simulated via custom paint would be complex,
          // so we use a subtle solid border for simplicity.
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
