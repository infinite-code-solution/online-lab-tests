import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Custom header 'Profile' (22px, w800) ──
              _buildHeader(),

              const SizedBox(height: 8),

              // ── Profile card with avatar, name, phone, edit profile ──
              _buildUserCard(context),

              const SizedBox(height: 16),

              // ── Info cards: Email & Location ──
              _buildInfoCards(),

              const SizedBox(height: 16),

              // ── Menu tiles with chevron_right ──
              _buildMenuSection(context),

              const SizedBox(height: 24),

              // ── Logout button ──
              _buildLogoutButton(context),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        'Profile',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
        ),
      ),
    );
  }

  // ── User card with Avatar & Details ────────────────────────

  Widget _buildUserCard(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar circle (80px) with person icon on iconBgTeal
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: AppColors.iconBgTeal,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 46,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Name
          const Text(
            'Rahul Sharma',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),

          // Phone
          const Text(
            '+91 98765 43210',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),

          // 'Edit Profile' outlined teal button
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Edit Profile coming soon'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(
              Icons.edit_outlined,
              size: 16,
              color: AppColors.primary,
            ),
            label: const Text(
              'Edit Profile',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  // ── Info cards: Email & Location ───────────────────────────

  Widget _buildInfoCards() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: 'rahul.sharma@email.com',
          ),
          const Divider(height: 1, indent: 64, color: AppColors.borderLight),
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: 'Hyderabad',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.iconBgTeal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Menu Section ───────────────────────────────────────────

  Widget _buildMenuSection(BuildContext context) {
    const menuItems = [
      _MenuItem(
        title: 'My Bookings',
        icon: Icons.calendar_month_outlined,
      ),
      _MenuItem(
        title: 'My Reports',
        icon: Icons.description_outlined,
      ),
      _MenuItem(
        title: 'Saved Addresses',
        icon: Icons.place_outlined,
      ),
      _MenuItem(
        title: 'Help & Support',
        icon: Icons.headset_mic_outlined,
      ),
      _MenuItem(
        title: 'About Us',
        icon: Icons.info_outline,
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: List.generate(menuItems.length, (index) {
          final item = menuItems[index];
          final isLast = index == menuItems.length - 1;

          return Column(
            children: [
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.title} clicked'),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                borderRadius: BorderRadius.vertical(
                  top: index == 0 ? const Radius.circular(18) : Radius.zero,
                  bottom: isLast ? const Radius.circular(18) : Radius.zero,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.iconBgTeal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          item.icon,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.textHint,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
              if (!isLast)
                const Divider(
                  height: 1,
                  indent: 64,
                  color: AppColors.borderLight,
                ),
            ],
          );
        }),
      ),
    );
  }

  // ── Logout Button ──────────────────────────────────────────

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton.icon(
          onPressed: () {
            // Logout navigates to LoginPage with pushAndRemoveUntil
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
          },
          icon: const Icon(
            Icons.logout,
            color: AppColors.primary,
            size: 20,
          ),
          label: const Text(
            'Logout',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;

  const _MenuItem({
    required this.title,
    required this.icon,
  });
}
