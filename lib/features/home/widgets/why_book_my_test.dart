import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class WhyBookMyTest extends StatelessWidget {
  const WhyBookMyTest({super.key});

  static const _features = [
    _Feature(icon: Icons.home_outlined, label: 'Home sample\ncollection'),
    _Feature(icon: Icons.shield_outlined, label: 'Trusted partner\nlabs'),
    _Feature(icon: Icons.description_outlined, label: 'Reports online'),
    _Feature(icon: Icons.local_offer_outlined, label: 'Transparent\npricing'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Why Book My Test',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 18),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
            ),
            itemCount: _features.length,
            itemBuilder: (context, i) => _FeatureCard(feature: _features[i]),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final _Feature feature;
  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.iconBgTeal,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(feature.icon, color: AppColors.primary, size: 20),
          ),
          const Spacer(),
          Text(
            feature.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _Feature {
  final IconData icon;
  final String label;
  const _Feature({required this.icon, required this.label});
}
