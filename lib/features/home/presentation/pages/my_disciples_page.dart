import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class MyDisciplesPage extends StatelessWidget {
  const MyDisciplesPage({super.key});

   static final List<Map<String, String>> _disciples = [
    {'name': 'Ana Clara', 'status': 'Novo Convertido'},
    {'name': 'Bruno Souza', 'status': 'Batizado'},
    {'name': 'Carlos Eduardo', 'status': 'Em Discipulado'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('MEUS DISCÍPULOS', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: _disciples.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final disciple = _disciples[index];
          return ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text(disciple['name']![0], style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
            title: Text(disciple['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(disciple['status']!, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            trailing: IconButton(
              icon: const Icon(Icons.chat, color: Colors.green),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Abrindo WhatsApp...')));
              },
            ),
          );
        },
      ),
    );
  }
}
