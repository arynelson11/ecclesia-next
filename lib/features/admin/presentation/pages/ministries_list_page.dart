import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

// --- LIST PAGE ---
// --- LIST PAGE ---
import '../../../../core/data/mock_database.dart';

class MinistriesListPage extends StatefulWidget {
  const MinistriesListPage({super.key});

  @override
  State<MinistriesListPage> createState() => _MinistriesListPageState();
}

class _MinistriesListPageState extends State<MinistriesListPage> {
  // Fetch from DB
  List<Map<String, dynamic>> _ministries = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _ministries = MockDatabase().getMinistries();
    });
  }

  void _showCreateModal() {
    final nameController = TextEditingController();
    int selectedIconCode = 0xe415; // default music
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Novo Ministério', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 24),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nome da Equipe',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Ícone Representativo', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            // Simple Icon Picker Mock
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconOption(0xe532, Colors.blue), // directions_car (Estacionamento mock)
                _buildIconOption(0xe165, Colors.orange),
                _buildIconOption(0xe25b, Colors.red),
                _buildIconOption(0xe415, Colors.purple),
              ],
            ),
             const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    final newMinistry = {
                      'id': DateTime.now().toString(),
                      'name': nameController.text,
                      'iconCode': 0xe532, // Mocking selection for demo
                      'colorValue': 0xFF607D8B, // BlueGrey
                      'leader': 'A definir',
                      'roles': ['Voluntário'],
                      'volunteers': <Map<String, String>>[],
                    };
                    MockDatabase().addMinistry(newMinistry);
                    _refreshData();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ministério criado com sucesso!')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('CRIAR EQUIPE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
             SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildIconOption(int code, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(IconData(code, fontFamily: 'MaterialIcons'), color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('MINISTÉRIOS E EQUIPES', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0, // Switched to 1.0 for better fit
          ),
          itemCount: _ministries.length,
          itemBuilder: (context, index) {
            return _MinistryCard(ministry: _ministries[index], onUpdate: _refreshData);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateModal,
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _MinistryCard extends StatelessWidget {
  final Map<String, dynamic> ministry;
  final VoidCallback onUpdate;
  const _MinistryCard({required this.ministry, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    // Handling dynamic data types safely
    final iconCode = ministry['iconCode'] as int;
    final colorVal = ministry['colorValue'] as int;
    final color = Color(colorVal);

    return GestureDetector(
      onTap: () async {
         await Navigator.push(context, MaterialPageRoute(builder: (_) => MinistryDetailPage(ministryId: ministry['id'])));
         onUpdate(); // Refresh list on return
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [AppTheme.kSoftShadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(IconData(iconCode, fontFamily: 'MaterialIcons'), color: color, size: 32),
            ),
            const SizedBox(height: 16),
            Text(ministry['name'], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${(ministry['volunteers'] as List).length} Voluntários',
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- DETAILS PAGE ---
class MinistryDetailPage extends StatefulWidget {
  final String ministryId;
  const MinistryDetailPage({super.key, required this.ministryId});

  @override
  State<MinistryDetailPage> createState() => _MinistryDetailPageState();
}

class _MinistryDetailPageState extends State<MinistryDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _ministry;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void _loadData() {
    final ministries = MockDatabase().getMinistries();
    final ministry = ministries.firstWhere((m) => m['id'] == widget.ministryId, orElse: () => {});
    setState(() {
      _ministry = ministry;
      _isLoading = false;
    });
  }

  void _showEditSettings() {
    final nameCtrl = TextEditingController(text: _ministry['name']);
    final leaderCtrl = TextEditingController(text: _ministry['leader']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Ministério'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nome')),
            const SizedBox(height: 12),
            TextField(controller: leaderCtrl, decoration: const InputDecoration(labelText: 'Líder Responsável')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              MockDatabase().updateMinistry(widget.ministryId, nameCtrl.text, leaderCtrl.text);
              _loadData();
              Navigator.pop(context);
            },
            child: const Text('SALVAR', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showAddVolunteer() {
    final nameCtrl = TextEditingController();
    final List<String> roles = List<String>.from(_ministry['roles'] ?? ['Voluntário']);
    String selectedRole = roles.first;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder( // StatefulBuilder to handle dropdown change
        builder: (context, setModalState) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Adicionar Voluntário', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                const SizedBox(height: 24),
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: 'Nome do Voluntário',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    filled: true, fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Função/Cargo', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButton<String>(
                    value: selectedRole,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: roles.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                    onChanged: (val) {
                      setModalState(() => selectedRole = val!);
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameCtrl.text.isNotEmpty) {
                        MockDatabase().addVolunteer(widget.ministryId, {'name': nameCtrl.text, 'role': selectedRole});
                        _loadData(); // Update UI
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${nameCtrl.text} adicionado como $selectedRole!')));
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                    child: const Text('ADICIONAR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_ministry.isEmpty) return const Scaffold(body: Center(child: Text('Erro ao carregar')));

    final iconCode = _ministry['iconCode'] as int;
    final colorVal = _ministry['colorValue'] as int;
    final color = Color(colorVal);

    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: Text(_ministry['name'].toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            onPressed: _showEditSettings,
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
          )
        ],
      ),
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(IconData(iconCode, fontFamily: 'MaterialIcons'), color: color, size: 40),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_ministry['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 16, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text('Líder: ${_ministry['leader']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Membros'),
                Tab(text: 'Escala'),
              ],
            ),
          ),
          
          const SizedBox(height: 24),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMembersTab(),
                _buildRosterTab(), // Keep mock for now as requested only volunteer logic update
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersTab() {
    final volunteers = _ministry['volunteers'] as List;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        if (volunteers.isEmpty) 
          const Padding(padding: EdgeInsets.all(32), child: Center(child: Text('Nenhum voluntário ainda.', style: TextStyle(color: Colors.grey)))),

        ...volunteers.map((m) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [AppTheme.kSoftShadow],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[200],
                child: Text(m['name']![0], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(m['role']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              const Icon(Icons.more_vert_rounded, color: Colors.grey),
            ],
          ),
        )).toList(),
        
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: _showAddVolunteer,
              icon: const Icon(Icons.add),
              label: const Text('ADICIONAR VOLUNTÁRIO'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRosterItem(String role, String name) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Container(
              width: 8, height: 8,
              decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            ),
            const SizedBox(width: 12),
            Text(role, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            const Spacer(),
            Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
      );
    }

  Widget _buildRosterTab() {
     // Mock Roster
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Próximo Culto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(8)),
                    child: const Text('Confirmado', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10)),
                  ),
                ],
              ),
              const Text('Domingo, 19:00', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
              const Divider(height: 32),
              _buildRosterItem(_ministry['roles']?[0] ?? 'Líder', 'João Silva'),
              _buildRosterItem(_ministry['roles']?[1] ?? 'Auxiliar', 'Maria Oliveira'),
            ],
          ),
        ),
      ],
    );
  }
}
