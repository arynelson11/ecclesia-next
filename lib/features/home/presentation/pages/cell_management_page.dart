import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CellManagementPage extends StatelessWidget {
  const CellManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('GESTÃO DE CÉLULAS', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // KPI Grid
            Row(
              children: [
                Expanded(child: _buildKPICard('Células Ativas', '12', Icons.groups, Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _buildKPICard('Presença Semanal', '85%', Icons.show_chart, primaryColor)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                 Expanded(child: _buildKPICard('Visitantes', '4', Icons.person_add, Colors.orange)),
                 const SizedBox(width: 16),
                 Expanded(child: _buildKPICard('Ofertas', 'R\$ 320', Icons.attach_money, Colors.green)),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Recent Reports
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Relatórios Recentes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('Ver Todos')),
              ],
            ),
            const SizedBox(height: 16),
            
            _buildReportCard('Célula Betel', 'Líder Carlos', '5 Membros • 1 Visitante', 'Enviado há 2h'),
            const SizedBox(height: 16),
            _buildReportCard('Célula Videira', 'Líder Roberto', '8 Membros • 0 Visitantes', 'Enviado há 5h'),
            const SizedBox(height: 16),
            _buildReportCard('Célula Jovens', 'Líder Fernanda', '12 Membros • 3 Visitantes', 'Enviado ontem'),
          ],
        ),
      ),
    );
  }

  Widget _buildKPICard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [AppTheme.kSoftShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildReportCard(String cellName, String leader, String summary, String time) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [AppTheme.kSoftShadow],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.summarize_outlined, color: Colors.black54),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cellName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(leader, style: const TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(summary, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(time, style: TextStyle(fontSize: 11, color: Colors.grey[400], fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
