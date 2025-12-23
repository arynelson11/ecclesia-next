import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../features/admin/presentation/pages/create_devotional_page.dart';
import '../../../../features/admin/presentation/pages/create_notice_page.dart';
import '../../../../features/admin/presentation/pages/members_list_page.dart';
import '../../../../features/admin/presentation/pages/financial_report_page.dart';
import '../../../../features/admin/presentation/pages/events_manager_page.dart';
import '../../../../features/admin/presentation/pages/ministries_list_page.dart';

class PastorHomePage extends StatelessWidget {
  const PastorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               // 1. Header & Search (Unique Identifier of this requested layout)
              _buildHeader(context),
              const SizedBox(height: 32),

              // 2. Metrics (Using the Asymmetric Grid Concept for key stats)
              const Text('Visão Geral', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 20),
              _buildMetricsGrid(context),
              
              const SizedBox(height: 32),
              
              // 3. Quick Actions (Bento Grid)
              const Text('Acesso Rápido', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 20),
              _buildBentoGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pr. Ricardo',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    letterSpacing: -1.0,
                  ),
                ),
                Text(
                  'Painel Administrativo',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 28),
                      onPressed: () => Navigator.pushNamed(context, '/leadership-requests'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8, right: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                IconButton(
                   icon: const Icon(Icons.settings_outlined, color: Colors.black),
                   onPressed: () => Navigator.pushNamed(context, '/master-admin'),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [AppTheme.kSoftShadow],
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=pastor'),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [AppTheme.kSoftShadow],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.black87, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar membro, evento...',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    // 60/40 Split for Metrics
    return SizedBox(
      height: 180,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FinancialReportPage())),
              child: Container(
                padding: const EdgeInsets.all(20), // Reduced padding from 24
                decoration: BoxDecoration(
                  color: Colors.black, // High contrast for main metric
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [AppTheme.kSoftShadow],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     // Removed Icon to save space or made small
                     // const Icon(Icons.show_chart_rounded, color: Colors.white, size: 32),
                     // Actually, let's keep it but organize better or use Flexible
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         const Text('Dízimos (Dez)', style: TextStyle(color: Colors.white70, fontSize: 14)),
                         const Icon(Icons.show_chart_rounded, color: Colors.white54, size: 20),
                      ],
                    ),
                    const Text('R\$ 42.5k', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                    
                    // Bar Chart
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                             _buildBar(30),
                             _buildBar(50),
                             _buildBar(40),
                             _buildBar(70),
                             _buildBar(55),
                             _buildBar(35),
                             _buildBar(60, isSelected: true),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MembersListPage())),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(30),
                   boxShadow: const [AppTheme.kSoftShadow],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     const Icon(Icons.people_alt_rounded, color: Colors.blue, size: 32),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: const [
                         Text('Membros', style: TextStyle(color: Colors.grey, fontSize: 12)),
                         Text('342', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w900)),
                       ],
                     ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBentoGrid(BuildContext context) {
    // Reusing the bento cards but organized
    return Column(
      children: [
        Row(
           children: [
             Expanded(
               child: _buildBentoCard(
                 context, 'Eventos', Icons.calendar_month_rounded, Colors.orange, 
                 () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventsManagerPage()))
               ),
             ),
             const SizedBox(width: 16),
             Expanded(
               child: _buildBentoCard(
                 context, 'Ministérios', Icons.volunteer_activism_rounded, Colors.purple,
                 () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MinistriesListPage()))
               ),
             ),
           ],
        ),
        const SizedBox(height: 16),
        Row(
            children: [
              Expanded(
                child: _buildBentoCard(
                  context, 'Novo Devocional', Icons.edit_note_rounded, Colors.black,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateDevotionalPage()))
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildBentoCard(
                  context, 'Gestão Células', Icons.groups, Colors.blue,
                  () => Navigator.pushNamed(context, '/cell-management')
                ),
              ),
            ],
        ),
      ],
    );
  }

  Widget _buildBentoCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [AppTheme.kSoftShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 28),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          ],
        ),
      ),
    );
  }
  Widget _buildBar(double height, {bool isSelected = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Container(
          height: height / 2, // Scale down
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white24,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
