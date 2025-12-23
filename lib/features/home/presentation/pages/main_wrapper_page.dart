import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/giving/presentation/pages/giving_page.dart';
import '../../../../features/bible/presentation/pages/bible_home_page.dart';
import '../../../../features/profile/presentation/pages/profile_page.dart';
import 'member_home_page.dart';
import 'pastor_home_page.dart';

class MainWrapperPage extends StatefulWidget {
  const MainWrapperPage({super.key});

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Watch AuthBloc to determine if user is ADMIN/PASTOR
    final authState = context.watch<AuthBloc>().state;
    bool isPastor = false;
    
    if (authState is AuthAuthenticated) {
      final role = authState.user.role;
      isPastor = role == 'PASTOR' || role == 'ADMIN';
    }

    // Build pages list dynamically
    final List<Widget> pages = [
      const MemberHomePage(),
      const BibleHomePage(),
      const GivingPage(),
      const ProfilePage(),
    ];

    if (isPastor) {
      pages.add(const PastorHomePage());
    }

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: _buildDarkCapsuleDock(context, isPastor),
    );
  }

  void _onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
  }

  Widget _buildDarkCapsuleDock(BuildContext context, bool isPastor) {
    return Container(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E), // Dark Gray / Almost Black
          borderRadius: BorderRadius.circular(40), // Capsule Shape
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDockIcon(0, Icons.home_filled),
            _buildDockIcon(1, Icons.menu_book_rounded),
            _buildDockIcon(2, Icons.volunteer_activism), // Giving is just another icon now in the reference style
            _buildDockIcon(3, Icons.person_rounded),
            
            if (isPastor)
               _buildDockIcon(4, Icons.dashboard_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildDockIcon(int index, IconData icon) {
    final bool isSelected = _currentIndex == index;
    
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent, // White circle for active
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.grey[600], // Dark icon for active, gray for inactive
          size: 24,
        ),
      ),
    );
  }
}
