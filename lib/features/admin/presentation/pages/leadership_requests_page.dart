import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/data/mock_database.dart';

class LeadershipRequestsPage extends StatefulWidget {
  const LeadershipRequestsPage({super.key});

  @override
  State<LeadershipRequestsPage> createState() => _LeadershipRequestsPageState();
}

class _LeadershipRequestsPageState extends State<LeadershipRequestsPage> {
  List<Map<String, String>> _requests = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _requests = MockDatabase().getLeadershipRequests();
    });
  }

  void _handleAction(String id, String name, bool approved) {
    if (approved) {
      MockDatabase().approveRequest(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Acesso liberado para $name!'),
        backgroundColor: Colors.green,
      ));
    } else {
      MockDatabase().rejectRequest(id);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Solicitação rejeitada.')));
    }
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('SOLICITAÇÕES', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: _requests.isEmpty 
        ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.check_circle_outline, size: 64, color: Colors.grey), SizedBox(height: 16), Text('Nenhuma solicitação pendente.')]))
        : ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: _requests.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final req = _requests[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [AppTheme.kSoftShadow],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(req['avatar']!),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(req['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(req['role']!, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => _handleAction(req['id']!, req['name']!, false),
                    ),
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => _handleAction(req['id']!, req['name']!, true),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}
