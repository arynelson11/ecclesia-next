import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CellReportPage extends StatefulWidget {
  const CellReportPage({super.key});

  @override
  State<CellReportPage> createState() => _CellReportPageState();
}

class _CellReportPageState extends State<CellReportPage> {
  int _visitors = 0;
  bool _hasOffering = false;
  final _themeController = TextEditingController();
  final _obsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('RELATÓRIO', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Estudo'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: TextField(
                controller: _themeController,
                decoration: const InputDecoration(hintText: 'Tema ministrado...', border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Visitantes'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Novas Pessoas', style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      _buildCounterBtn(Icons.remove, () => setState(() => _visitors = _visitors > 0 ? _visitors - 1 : 0)),
                      SizedBox(width: 40, child: Text(_visitors.toString(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                      _buildCounterBtn(Icons.add, () => setState(() => _visitors++)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Oferta'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Houve Oferta?', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Marque se houve recolhimento.'),
                value: _hasOffering,
                activeColor: Colors.green,
                onChanged: (val) => setState(() => _hasOffering = val),
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Observações'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: TextField(
                controller: _obsController,
                maxLines: 4,
                decoration: const InputDecoration(hintText: 'Algum pedido de oração ou detalhe importante...', border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 48),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.pop(context);
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Relatório enviado para o Pastor!')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('ENVIAR RELATÓRIO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _buildCounterBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
