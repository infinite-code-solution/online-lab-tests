import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Book My Test',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Left column ──
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _footerLink('About Us'),
                    _footerLink('Blood Tests'),
                    _footerLink('FAQs'),
                    _footerLink('Privacy Policy'),
                  ],
                ),
              ),
              // ── Right column ──
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _footerLink('Contact Us'),
                    _footerLink('Scans'),
                    _footerLink('Terms & Conditions'),
                    _footerLink('Refund & Cancellation'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
