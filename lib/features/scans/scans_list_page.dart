import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../book_scan/book_scan_page.dart';

class ScansListPage extends StatefulWidget {
  const ScansListPage({super.key});

  @override
  State<ScansListPage> createState() => _ScansListPageState();
}

class _ScansListPageState extends State<ScansListPage> {
  int _currentBanner = 0;
  final PageController _bannerController = PageController();
  Timer? _bannerTimer;

  static const _banners = [
    _BannerInfo(
      title: 'Scans near you',
      subtitle: 'Compare centers and book a slot.',
    ),
    _BannerInfo(
      title: 'MRI & CT scans\nat best prices',
      subtitle: 'Trusted scan centers near\nyour location.',
    ),
    _BannerInfo(
      title: 'Book your\nultrasound online',
      subtitle: 'Instant appointment\nconfirmation.',
    ),
  ];

  static const _scans = [
    _ScanItem(name: 'MRI Brain', tag: 'Choose a scan center', price: '₹4,500'),
    _ScanItem(name: 'CT Chest', tag: 'Choose a scan center', price: '₹3,200'),
    _ScanItem(
        name: 'Ultrasound Abdomen',
        tag: 'Choose a scan center',
        price: '₹1,800'),
  ];

  @override
  void initState() {
    super.initState();
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final next = (_currentBanner + 1) % _banners.length;
      _bannerController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  void _onBookScan(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const BookScanPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Fixed header ──
            _buildTopBar(context),
            _buildSearchBar(),

            // ── Scrollable content ──
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // ── Banner carousel ──
                  SliverToBoxAdapter(child: _buildBannerCarousel()),

                  // ── Section header ──
                  SliverToBoxAdapter(child: _buildSectionHeader()),

                  // ── Scans list ──
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) => _ScanCard(
                          scan: _scans[i],
                          onBook: () => _onBookScan(context),
                        ),
                        childCount: _scans.length,
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Top bar (fixed) ───────────────────────────────────────

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: const Icon(
                Icons.chevron_left,
                color: AppColors.primary,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Scans',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // ── Search bar (fixed) ────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon:
              const Icon(Icons.search, color: AppColors.textHint, size: 24),
          hintText: 'Search scans',
          hintStyle:
              const TextStyle(color: AppColors.textHint, fontSize: 15),
          filled: true,
          fillColor: AppColors.cardBg,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
        ),
      ),
    );
  }

  // ── Banner carousel ───────────────────────────────────────

  Widget _buildBannerCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _currentBanner = i),
            itemBuilder: (context, i) =>
                _ScanBannerCard(data: _banners[i]),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (i) {
            final isActive = i == _currentBanner;
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
        ),
      ],
    );
  }

  // ── Section header ────────────────────────────────────────

  Widget _buildSectionHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 14),
      child: Text(
        'Most booked scans',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

// ── Scan banner card ─────────────────────────────────────────

class _ScanBannerCard extends StatelessWidget {
  final _BannerInfo data;
  const _ScanBannerCard({required this.data});

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
          Positioned(
            right: -10,
            top: -10,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: AppColors.amber.withValues(alpha: 0.85),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.scaffoldBg.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 120, 20),
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

// ── Scan list card ────────────────────────────────────────────

class _ScanCard extends StatelessWidget {
  final _ScanItem scan;
  final VoidCallback? onBook;
  const _ScanCard({required this.scan, this.onBook});

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
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.iconBgTeal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.center_focus_weak_outlined,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scan.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  scan.tag,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  scan.price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
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

// ── Data models ───────────────────────────────────────────────

class _BannerInfo {
  final String title;
  final String subtitle;
  const _BannerInfo({required this.title, required this.subtitle});
}

class _ScanItem {
  final String name;
  final String tag;
  final String price;
  const _ScanItem(
      {required this.name, required this.tag, required this.price});
}
