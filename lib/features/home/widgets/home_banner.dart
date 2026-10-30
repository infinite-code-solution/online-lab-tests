import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<_BannerData> _banners = const [
    _BannerData(
      title: 'Health checks,\nbooked in minutes',
      subtitle: 'Home sample collection from\ntrusted partner labs.',
    ),
    _BannerData(
      title: 'Full body\ncheckup at ₹999',
      subtitle: '70+ tests including CBC,\nLipid, Thyroid & more.',
    ),
    _BannerData(
      title: 'Diabetes\ncare package',
      subtitle: 'HbA1c, Fasting Sugar &\nPost-Prandial Sugar.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final next = (_currentPage + 1) % _banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 175,
          child: PageView.builder(
            controller: _controller,
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, i) => _BannerCard(data: _banners[i]),
          ),
        ),
        const SizedBox(height: 12),
        _DotIndicators(
          count: _banners.length,
          current: _currentPage,
        ),
      ],
    );
  }
}

// ── Banner card ──────────────────────────────────────────────

class _BannerCard extends StatelessWidget {
  final _BannerData data;
  const _BannerCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // ── Decorative shapes ──
          Positioned(
            right: -10,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.amber.withValues(alpha: 0.85),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 40,
            bottom: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 80,
            top: 10,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.scaffoldBg.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // ── Text content ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 100, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13,
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

// ── Dot indicators ──────────────────────────────────────────

class _DotIndicators extends StatelessWidget {
  final int count;
  final int current;
  const _DotIndicators({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 10 : 7,
          height: isActive ? 10 : 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.25),
          ),
        );
      }),
    );
  }
}

// ── Data class ──────────────────────────────────────────────

class _BannerData {
  final String title;
  final String subtitle;
  const _BannerData({required this.title, required this.subtitle});
}
