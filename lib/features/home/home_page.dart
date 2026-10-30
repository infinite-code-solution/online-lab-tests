import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'widgets/home_banner.dart';
import 'widgets/category_card.dart';
import 'widgets/test_card.dart';
import 'widgets/why_book_my_test.dart';
import 'widgets/partner_labs.dart';
import 'widgets/customer_testimonials.dart';
import 'widgets/app_footer.dart';
import '../auth/login_page.dart';
import '../book_blood_test/book_blood_test_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedLocation = 'Hyderabad';

  static const _locations = [
    'Hyderabad',
    'Bangalore',
    'Mumbai',
    'Delhi',
    'Chennai',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // ── Fixed header ──
          _buildTopBar(context),
          _buildLocationRow(),

          // ── Scrollable content ──
          Expanded(
            child: CustomScrollView(
              slivers: [
                // ── Search bar ───────────────────────────────
                SliverToBoxAdapter(child: _buildSearchBar()),

                // ── Banner carousel ──────────────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: HomeBanner(),
                  ),
                ),

                // ── Category cards ───────────────────────────
                SliverToBoxAdapter(child: _buildCategories()),

                // ── Most booked header ───────────────────────
                SliverToBoxAdapter(child: _buildMostBookedHeader()),

                // ── Most booked tests list ───────────────────
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      TestCard(
                        name: 'Complete Blood Count\n(CBC)',
                        tag: 'Popular',
                        price: '₹349',
                        onBook: () => _navigateToBookBloodTest(context),
                      ),
                      TestCard(
                        name: 'HbA1c',
                        tag: 'Popular',
                        price: '₹499',
                        onBook: () => _navigateToBookBloodTest(context),
                      ),
                      TestCard(
                        name: 'Lipid Profile',
                        tag: 'Popular',
                        price: '₹699',
                        onBook: () => _navigateToBookBloodTest(context),
                      ),
                      const SizedBox(height: 8),
                    ]),
                  ),
                ),

                // ── Why Book My Test ─────────────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: WhyBookMyTest(),
                  ),
                ),

                // ── Partner labs & centers ────────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: PartnerLabs(),
                  ),
                ),

                // ── Customer testimonials ────────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: CustomerTestimonials(),
                  ),
                ),

                // ── Footer ───────────────────────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 32),
                    child: AppFooter(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Navigation helpers ──────────────────────────────────

  void _navigateToBookBloodTest(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const BookBloodTestPage()),
    );
  }

  // ── Top bar (fixed) ─────────────────────────────────────

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          // Logo icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.add, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 10),
          const Text(
            'Book My Test',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
            child: const Text(
              'Login / Sign up',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Location row (fixed) ────────────────────────────────

  Widget _buildLocationRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          // Location dropdown
          GestureDetector(
            onTap: _showLocationPicker,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on_outlined,
                      color: AppColors.primary, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    _selectedLocation,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary, size: 20),
                ],
              ),
            ),
          ),
          const Spacer(),
          _actionIcon(Icons.chat_bubble_outline),
          const SizedBox(width: 8),
          _actionIcon(Icons.phone_outlined),
          const SizedBox(width: 8),
          _actionIcon(Icons.shopping_cart_outlined),
        ],
      ),
    );
  }

  void _showLocationPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Location',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(_locations.length, (i) {
              final city = _locations[i];
              final isSelected = city == _selectedLocation;
              return ListTile(
                leading: Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
                title: Text(
                  city,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                onTap: () {
                  setState(() => _selectedLocation = city);
                  Navigator.pop(ctx);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _actionIcon(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Icon(icon, color: AppColors.primary, size: 22),
    );
  }

  // ── Search bar ──────────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon:
              const Icon(Icons.search, color: AppColors.textHint, size: 24),
          hintText: 'Search tests, packages or scans',
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

  // ── Category cards ──────────────────────────────────────

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: CategoryCard(
              icon: Icons.water_drop_outlined,
              title: 'Blood Tests',
              subtitle: 'Home sample collection',
              tint: AppColors.bloodTestTint,
              onTap: () {
                // Switch to Blood Tests tab (index 1)
                final shell = context.findAncestorStateOfType<State>();
                if (shell != null && shell.mounted) {
                  // Use a callback from MainShell if available
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CategoryCard(
              icon: Icons.center_focus_weak_outlined,
              title: 'Scans',
              subtitle: 'Choose a nearby center',
              tint: AppColors.scanTint,
              onTap: () {
                // Switch to Scans tab (index 2)
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Most booked header ──────────────────────────────────

  Widget _buildMostBookedHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Most booked tests',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'View all',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
