import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../home/widgets/test_card.dart';
import '../book_blood_test/book_blood_test_page.dart';

class BloodTestsPage extends StatefulWidget {
  const BloodTestsPage({super.key});

  @override
  State<BloodTestsPage> createState() => _BloodTestsPageState();
}

class _BloodTestsPageState extends State<BloodTestsPage> {
  int _selectedFilter = 0;
  int _currentBanner = 0;
  final PageController _bannerController = PageController();
  Timer? _bannerTimer;

  static const _filters = ['Blood Tests', 'Health Packages'];

  static const _banners = [
    _BannerInfo(
      title: 'Full body checkups',
      subtitle: 'Save on packages booked this\nmonth.',
    ),
    _BannerInfo(
      title: 'Diabetes care\npackage',
      subtitle: 'HbA1c, Fasting Sugar &\nPost-Prandial Sugar.',
    ),
    _BannerInfo(
      title: 'Heart health\ncheckup',
      subtitle: 'Lipid Profile, ECG & more\nat special prices.',
    ),
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

  void _onBookTest(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const BookBloodTestPage()),
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

                  // ── Filter chips ──
                  SliverToBoxAdapter(child: _buildFilterChips()),

                  // ── Section header ──
                  SliverToBoxAdapter(child: _buildSectionHeader()),

                  // ── Test list ──
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        TestCard(
                          name: 'Complete Blood Count\n(CBC)',
                          tag: 'Home sample collection',
                          price: '₹349',
                          onBook: () => _onBookTest(context),
                        ),
                        TestCard(
                          name: 'Thyroid Profile (T3, T4,\nTSH)',
                          tag: 'Home sample collection',
                          price: '₹599',
                          onBook: () => _onBookTest(context),
                        ),
                        TestCard(
                          name: 'Vitamin D (25-OH)',
                          tag: 'Home sample collection',
                          price: '₹899',
                          onBook: () => _onBookTest(context),
                        ),
                        const SizedBox(height: 16),
                      ]),
                    ),
                  ),
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
            'Blood Tests',
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
          hintText: 'Search blood tests',
          hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 15),
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
          height: 175,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _currentBanner = i),
            itemBuilder: (context, i) =>
                _BloodTestBanner(data: _banners[i]),
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

  // ── Filter chips ──────────────────────────────────────────

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: List.generate(_filters.length, (i) {
          final isSelected = i == _selectedFilter;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.cardBg,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Text(
                  _filters[i],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:
                        isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── Section header ────────────────────────────────────────

  Widget _buildSectionHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Text(
        'Recommended by Expert Doctors',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

// ── Banner card ─────────────────────────────────────────────

class _BloodTestBanner extends StatelessWidget {
  final _BannerInfo data;
  const _BloodTestBanner({required this.data});

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
            padding: const EdgeInsets.fromLTRB(20, 28, 120, 20),
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

class _BannerInfo {
  final String title;
  final String subtitle;
  const _BannerInfo({required this.title, required this.subtitle});
}
