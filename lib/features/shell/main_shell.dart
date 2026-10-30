import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../home/home_page.dart';
import '../blood_tests/blood_tests_page.dart';
import '../scans/scans_list_page.dart';
import '../cart/cart_page.dart';
import '../profile/profile_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    BloodTestsPage(),
    ScansListPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.navInactive,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w600, height: 1.6),
              unselectedLabelStyle: const TextStyle(height: 1.6),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.water_drop_outlined),
                  activeIcon: Icon(Icons.water_drop),
                  label: 'Blood Tests',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.center_focus_weak_outlined),
                  activeIcon: Icon(Icons.center_focus_weak),
                  label: 'Scans',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined),
                  activeIcon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
