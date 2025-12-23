import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/prayer_card.dart';

class PrayerWallPage extends StatefulWidget {
  const PrayerWallPage({super.key});

  @override
  State<PrayerWallPage> createState() => _PrayerWallPageState();
}

class _PrayerWallPageState extends State<PrayerWallPage> {
  int _selectedFilter = 0; // 0: Todos, 1: Meus

  // Mock Data
  final List<Map<String, dynamic>> _prayers = [
    {
      'authorName': 'Ana Clara',
      'authorAvatarUrl': 'https://i.pravatar.cc/150?u=ana',
      'timeAgo': 'há 2h',
      'content': 'Peço oração pela minha mãe que vai passar por uma cirurgia amanhã. Que Deus guie as mãos dos médicos.',
      'category': 'Saúde',
      'count': 12,
    },
    {
      'authorName': 'Carlos Eduardo',
      'authorAvatarUrl': 'https://i.pravatar.cc/150?u=carlos',
      'timeAgo': 'há 5h',
      'content': 'Orando por uma porta de emprego que se abriu. Peço sabedoria na entrevista.',
      'category': 'Emprego',
      'count': 8,
    },
    {
      'authorName': 'Beatriz Souza',
      'authorAvatarUrl': 'https://i.pravatar.cc/150?u=bia',
      'timeAgo': 'há 1d',
      'content': 'Pela restauração do casamento dos meus pais. Eles estão passando por um momento difícil.',
      'category': 'Família',
      'count': 24,
    },
  ];

  void _addNewPrayer(String content) {
    setState(() {
      _prayers.insert(0, {
        'authorName': 'Você',
        'authorAvatarUrl': 'https://i.pravatar.cc/300', // Current user mock
        'timeAgo': 'agora',
        'content': content,
        'category': 'Fé',
        'count': 0,
      });
    });
  }

  void _showCreateModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _NewRequestModal(onSubmit: _addNewPrayer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('MURAL DE ORAÇÃO', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                _buildFilterChip(0, 'Todos'),
                const SizedBox(width: 12),
                _buildFilterChip(1, 'Meus Pedidos'),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.separated(
              itemCount: _prayers.length,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
              separatorBuilder: (_, __) => const SizedBox(width: 0), // Already handled by card margin
              itemBuilder: (context, index) {
                final prayer = _prayers[index];
                return PrayerCard(
                  authorName: prayer['authorName'],
                  authorAvatarUrl: prayer['authorAvatarUrl'],
                  timeAgo: prayer['timeAgo'],
                  content: prayer['content'],
                  category: prayer['category'],
                  initialPrayerCount: prayer['count'],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateModal,
        backgroundColor: Colors.black,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text("Novo Pedido", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _buildFilterChip(int index, String label) {
    final isSelected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _NewRequestModal extends StatefulWidget {
  final Function(String) onSubmit;

  const _NewRequestModal({required this.onSubmit});

  @override
  State<_NewRequestModal> createState() => _NewRequestModalState();
}

class _NewRequestModalState extends State<_NewRequestModal> {
  final TextEditingController _controller = TextEditingController();
  bool _isPublic = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Como podemos orar por você?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Digite seu pedido de oração...',
              filled: true,
              fillColor: AppTheme.kBackground,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Switch(
                value: _isPublic,
                activeColor: Colors.black,
                onChanged: (val) => setState(() => _isPublic = val),
              ),
              const SizedBox(width: 8),
              Text(
                _isPublic ? 'Público (Todos veem)' : 'Privado (Apenas Pastores)',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  widget.onSubmit(_controller.text);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: const Text('ENVIAR PEDIDO', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
