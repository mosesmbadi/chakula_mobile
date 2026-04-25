import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/app_colors.dart';
import 'home/home_screen.dart';
import 'log/log_screen.dart';
import 'discover/discover_screen.dart';
import 'profile/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const LogScreen(),
    const DiscoverScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.accent,
          unselectedItemColor: AppColors.accent.withValues(alpha: 0.4),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            _buildNavItem(0, 'Home', FontAwesomeIcons.house),
            _buildNavItem(1, 'Log', FontAwesomeIcons.book),
            _buildNavItem(2, 'Discover', FontAwesomeIcons.compass),
            _buildNavItem(3, 'Profile', FontAwesomeIcons.user),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(int index, String label, IconData icon) {
    final isSelected = _selectedIndex == index;
    return BottomNavigationBarItem(
      icon: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: FaIcon(
          icon,
          size: 20,
        ),
      ),
      label: label,
    );
  }
}
