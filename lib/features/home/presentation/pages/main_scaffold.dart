import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../features/home/presentation/pages/member_home_page.dart';
import '../../../../features/bible/presentation/pages/bible_home_page.dart';
import '../../../../features/giving/presentation/pages/giving_page.dart';
import '../../../../features/profile/presentation/pages/profile_page.dart';
import '../../../../features/home/presentation/pages/pastor_home_page.dart';
import '../../../../features/home/presentation/pages/leader_home_page.dart';

class MainScaffold extends StatefulWidget {
  final String userRole; // 'admin', 'pastor', 'leader', 'member'

  const MainScaffold({super.key, required this.userRole});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const MemberHomePage(),
      const BibleHomePage(),
      const GivingPage(),
      const ProfilePage(),
      _buildRoleBasedPage(),
    ];
  }

  Widget _buildRoleBasedPage() {
    if (widget.userRole == 'admin' || widget.userRole == 'pastor') {
      return const PastorHomePage();
    } else if (widget.userRole == 'leader') {
      return const LeaderHomePage();
    } else {
      return _buildMemberMenu();
    }
  }

  Widget _buildMemberMenu() {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(title: const Text('Menu', style: TextStyle(color: Colors.black)), backgroundColor: Colors.white, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildMenuItem('Configurações', Icons.settings),
          _buildMenuItem('Ajuda', Icons.help_outline),
          _buildMenuItem('Sobre a Igreja', Icons.info_outline),
          const Divider(),
          _buildMenuItem('Sair', Icons.logout, color: Colors.red, onTap: () => Navigator.pushReplacementNamed(context, '/login')),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, {Color color = Colors.black, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Início'),
            const BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bíblia'),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                child: const Icon(Icons.volunteer_activism, color: Colors.white, size: 20),
              ),
              label: '',
            ),
            const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
            _getRoleBasedTabItem(),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _getRoleBasedTabItem() {
    if (widget.userRole == 'admin' || widget.userRole == 'pastor') {
      return const BottomNavigationBarItem(icon: Icon(Icons.dashboard_customize), label: 'Gestão');
    } else if (widget.userRole == 'leader') {
      return const BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Liderança');
    } else {
      return const BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu');
    }
  }
}
