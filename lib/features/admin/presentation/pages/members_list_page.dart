import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
// import 'package:url_launcher/url_launcher_string.dart';

// --- LIST PAGE ---
class MembersListPage extends StatefulWidget {
  const MembersListPage({super.key});

  @override
  State<MembersListPage> createState() => _MembersListPageState();
}

class _MembersListPageState extends State<MembersListPage> {
  // Mock Data - 15 Members
  final List<Map<String, dynamic>> _allMembers = [
    {
      'id': '1',
      'name': 'Maria Silva',
      'role': 'Líder de Célula',
      'status': 'Ativo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=maria',
      'phone': '11999990001',
      'email': 'maria@email.com',
      'birthday': '12/Dez', // Birthday in current month for demo
      'tenure': '5 anos',
      'marital': 'Casada',
      'financialStatus': 'Regular ✅',
      'notes': 'Visitou o hospital semana passada.',
    },
    {
      'id': '2',
      'name': 'João Santos',
      'role': 'Membro',
      'status': 'Novo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=joao',
      'phone': '11999990002',
      'email': 'joao@email.com',
      'birthday': '05/Jun',
      'tenure': '2 meses',
      'marital': 'Solteiro',
      'financialStatus': 'Irregular ⚠️',
      'notes': 'Está fazendo o curso de batismo.',
    },
    {
      'id': '3',
      'name': 'Pedro Oliveira',
      'role': 'Diácono',
      'status': 'Ativo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=pedro',
      'phone': '11999990003',
      'email': 'pedro@email.com',
      'birthday': '22/Set',
      'tenure': '8 anos',
      'marital': 'Casado',
      'financialStatus': 'Fiel 💎',
      'notes': 'Responsável pela recepção.',
    },
    {
      'id': '4',
      'name': 'Ana Costa',
      'role': 'Membro',
      'status': 'Ausente',
      'avatarUrl': 'https://i.pravatar.cc/150?u=ana',
      'phone': '11999990004',
      'email': 'ana@email.com',
      'birthday': '15/Jan',
      'tenure': '1 ano',
      'marital': 'Solteira',
      'financialStatus': 'Pendente ⭕',
      'notes': 'Precisa de visita pastoral.',
    },
    {
      'id': '5',
      'name': 'Lucas Pereira',
      'role': 'Líder de Jovens',
      'status': 'Ativo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=lucas',
      'phone': '11999990005',
      'email': 'lucas@email.com',
      'birthday': '30/Nov',
      'tenure': '3 anos',
      'marital': 'Noivo',
      'financialStatus': 'Regular ✅',
      'notes': 'Planejando o retiro de carnaval.',
    },
    {
      'id': '6',
      'name': 'Carla Diaz',
      'role': 'Prof. Infantil',
      'status': 'Ativo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=carla',
      'phone': '11999990006',
      'email': 'carla@email.com',
      'birthday': '25/Dez', // Birthday
      'tenure': '4 anos',
      'marital': 'Casada',
      'financialStatus': 'Regular ✅',
      'notes': '',
    },
    {
      'id': '7',
      'name': 'Marcos Rocha',
      'role': 'Membro',
      'status': 'Novo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=marcos',
      'phone': '11999990007',
      'email': 'marcos@email.com',
      'birthday': '01/Fev',
      'tenure': '1 mês',
      'marital': 'Casado',
      'financialStatus': 'Novo ⭐',
      'notes': 'Veio transferido de outra cidade.',
    },
    {
      'id': '8',
      'name': 'Julia Lima',
      'role': 'Louvor',
      'status': 'Ativo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=julia',
      'phone': '11999990008',
      'email': 'julia@email.com',
      'birthday': '19/Mai',
      'tenure': '6 anos',
      'marital': 'Solteira',
      'financialStatus': 'Regular ✅',
      'notes': '',
    },
    {
      'id': '9',
      'name': 'Roberto Alves',
      'role': 'Membro',
      'status': 'Inativo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=roberto',
      'phone': '11999990009',
      'email': 'beto@email.com',
      'birthday': '04/Abr',
      'tenure': '10 anos',
      'marital': 'Divorciado',
      'financialStatus': 'Pendente ⭕',
      'notes': 'Não aparece há 3 meses.',
    },
    {
      'id': '10',
      'name': 'Fernanda Torres',
      'role': 'Mídia',
      'status': 'Ativo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=fernanda',
      'phone': '11999990010',
      'email': 'nanda@email.com',
      'birthday': '28/Jul',
      'tenure': '2 anos',
      'marital': 'Solteira',
      'financialStatus': 'Regular ✅',
      'notes': '',
    },
    {
      'id': '11',
      'name': 'Gustavo Mendes',
      'role': 'Membro',
      'status': 'Ativo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=gustavo',
      'phone': '11999990011',
      'email': 'gus@email.com',
      'birthday': '10/Dez', // Birthday
      'tenure': '1 ano',
      'marital': 'Solteiro',
      'financialStatus': 'Regular ✅',
      'notes': '',
    },
    {
      'id': '12',
      'name': 'Patricia Lins',
      'role': 'Líder de Mulheres',
      'status': 'Ativo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=patricia',
      'phone': '11999990012',
      'email': 'pati@email.com',
      'birthday': '03/Ago',
      'tenure': '7 anos',
      'marital': 'Casada',
      'financialStatus': 'Fiel 💎',
      'notes': '',
    },
    {
      'id': '13',
      'name': 'Ricardo Souza',
      'role': 'Membro',
      'status': 'Novo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=ricardo',
      'phone': '11999990013',
      'email': 'rick@email.com',
      'birthday': '12/Out',
      'tenure': '3 semanas',
      'marital': 'Casado',
      'financialStatus': 'Novo ⭐',
      'notes': '',
    },
    {
      'id': '14',
      'name': 'Sonia Braga',
      'role': 'Intercessão',
      'status': 'Ativo',
      'avatarUrl': 'https://i.pravatar.cc/150?u=sonia',
      'phone': '11999990014',
      'email': 'sonia@email.com',
      'birthday': '05/Set',
      'tenure': '15 anos',
      'marital': 'Viúva',
      'financialStatus': 'Fiel 💎',
      'notes': 'Mãe de oração da igreja.',
    },
    {
      'id': '15',
      'name': 'Felipe Neto',
      'role': 'Membro',
      'status': 'Ausente',
      'avatarUrl': 'https://i.pravatar.cc/150?u=felipe',
      'phone': '11999990015',
      'email': 'lipe@email.com',
      'birthday': '20/Mar',
      'tenure': '5 meses',
      'marital': 'Solteiro',
      'financialStatus': 'Irregular ⚠️',
      'notes': '',
    },
  ];

  String _searchQuery = '';
  int _selectedFilter = 0; // 0: Todos, 1: Liderança, 2: Aniversariantes

  List<Map<String, dynamic>> get _filteredMembers {
    return _allMembers.where((m) {
      final matchesSearch = m['name'].toLowerCase().contains(_searchQuery.toLowerCase()) || 
                            m['phone'].contains(_searchQuery) ||
                            m['role'].toLowerCase().contains(_searchQuery.toLowerCase());
      
      bool matchesFilter = true;
      if (_selectedFilter == 1) matchesFilter = m['role'].toString().contains('Líder') || m['role'].contains('Diácono') || m['role'].contains('Prof');
      if (_selectedFilter == 2) matchesFilter = m['birthday'].toString().contains('Dez'); // Mock logic for December

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('MEMBROS DA IGREJA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [AppTheme.kSoftShadow],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                       onChanged: (val) => setState(() => _searchQuery = val),
                       decoration: const InputDecoration(
                         hintText: 'Buscar por nome, telefone ou cargo...',
                         border: InputBorder.none,
                         filled: false,
                         contentPadding: EdgeInsets.only(bottom: 12),
                       ),
                       style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
               children: [
                 _buildFilterChip(0, 'Todos'),
                 const SizedBox(width: 8),
                 _buildFilterChip(1, 'Liderança'),
                 const SizedBox(width: 8),
                 _buildFilterChip(2, 'Aniversariantes'),
               ],
            ),
          ),
          
          const SizedBox(height: 16),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: _filteredMembers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _MemberCard(member: _filteredMembers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(int index, String label) {
    final isSelected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final Map<String, dynamic> member;
  const _MemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MemberDetailAdminPage(member: member))),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [AppTheme.kSoftShadow],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(member['avatarUrl']),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member['name'], style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: member['status'] == 'Ativo' ? Colors.green.withOpacity(0.1) : Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(member['status'].toUpperCase(), style: TextStyle(
                          fontSize: 10, 
                          fontWeight: FontWeight.bold,
                          color: member['status'] == 'Ativo' ? Colors.green : Colors.grey
                        )),
                      ),
                      const SizedBox(width: 8),
                      // Flexible to avoid overflow with long roles
                      Flexible(
                        child: Text(
                          member['role'], 
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w600)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Abrindo WhatsApp...')));
              }, 
              icon: const Icon(Icons.message_rounded, color: Colors.green),
              style: IconButton.styleFrom(
                backgroundColor: Colors.green.withOpacity(0.1),
                shape: const CircleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- DETAILS PAGE ---
class MemberDetailAdminPage extends StatelessWidget {
  final Map<String, dynamic> member;
  const MemberDetailAdminPage({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('PERFIL DO MEMBRO', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header Profile
            Column(
              children: [
                CircleAvatar( radius: 50, backgroundImage: NetworkImage(member['avatarUrl']) ),
                const SizedBox(height: 16),
                Text(member['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                Text(member['role'], style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w600)),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(context, Icons.call, Colors.blue, 'Ligar'),
                    const SizedBox(width: 16),
                    _buildActionButton(context, Icons.email, Colors.grey, 'Email'),
                    const SizedBox(width: 16),
                    _buildActionButton(context, Icons.message_rounded, Colors.green, 'WhatsApp'),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Stats Grid
            Row(
              children: [
                Expanded(child: _buildInfoCard('Aniversário', member['birthday'], Icons.cake_rounded, Colors.purple)),
                const SizedBox(width: 12),
                Expanded(child: _buildInfoCard('Membro desde', member['tenure'], Icons.hourglass_bottom_rounded, Colors.orange)),
                const SizedBox(width: 12),
                Expanded(child: _buildInfoCard('Estado Civil', member['marital'], Icons.favorite_rounded, Colors.red)),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Financial Summary (Sensitive)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [AppTheme.kSoftShadow],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                       Icon(Icons.monetization_on_rounded, color: Colors.green, size: 20),
                       SizedBox(width: 8),
                       Text('Dízimos (Últimos 3 meses)', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(member['financialStatus'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Pastoral Notes
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Anotações Pastorais', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                const SizedBox(height: 12),
                TextField(
                  maxLines: 4,
                  controller: TextEditingController(text: member['notes']),
                  decoration: InputDecoration(
                    hintText: 'Escreva uma observação...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, Color color, String tooltip) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$tooltip acionado!')));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [AppTheme.kSoftShadow],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
