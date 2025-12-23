import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CellAttendancePage extends StatefulWidget {
  const CellAttendancePage({super.key});

  @override
  State<CellAttendancePage> createState() => _CellAttendancePageState();
}

class _CellAttendancePageState extends State<CellAttendancePage> {
  // Mock Members
  final List<Map<String, dynamic>> _members = [
    {'name': 'Ana Clara', 'present': false},
    {'name': 'Bruno Souza', 'present': false},
    {'name': 'Carlos Eduardo', 'present': false},
    {'name': 'Daniela Lima', 'present': false},
    {'name': 'Eduardo Silva', 'present': false},
    {'name': 'Fernanda Costa', 'present': false},
     {'name': 'Gabriel Torres', 'present': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('CHAMADA - CÉLULA BETEL', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.0, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: _members.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final member = _members[index];
                return CheckboxListTile(
                  value: member['present'],
                  activeColor: Colors.black,
                  onChanged: (val) => setState(() => member['present'] = val),
                  title: Text(member['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  secondary: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Text(member['name'][0], style: const TextStyle(color: Colors.black)),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  tileColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  final presentCount = _members.where((m) => m['present']).length;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Chamada salva! $presentCount presentes.'))
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('SALVAR PRESENÇA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
