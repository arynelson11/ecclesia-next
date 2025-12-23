

class MockDatabase {
  // Singleton
  static final MockDatabase _instance = MockDatabase._internal();
  factory MockDatabase() => _instance;
  MockDatabase._internal();

  // In-Memory Storage
  final List<Map<String, String>> _devotionals = [
    {
      'title': 'A Paz que excede todo entendimento',
      'category': 'VIDA CRISTÃ',
      'summary': 'Como encontrar tranquilidade em meio ao caos da vida moderna seguindo os passos de Jesus.',
      'imageUrl': 'https://images.unsplash.com/photo-1507692049790-de58293a4697?auto=format&fit=crop&q=80&w=800',
    },
    {
      'title': 'Fé x Ansiedade',
      'category': 'SAÚDE EMOCIONAL',
      'summary': 'A ansiedade não é falta de fé, mas a fé é a resposta para a ansiedade. Entenda a diferença.',
      'imageUrl': 'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?auto=format&fit=crop&q=80&w=800',
    },
    {
      'title': 'O Poder da Oração',
      'category': 'ESPIRITUALIDADE',
      'summary': 'Três chaves para uma vida de oração consistente e poderosa.',
      'imageUrl': 'https://images.unsplash.com/photo-1490730141103-6cac27aaab94?auto=format&fit=crop&q=80&w=800',
    },
  ];

  final List<Map<String, dynamic>> _events = [
    {
      'title': 'Culto da Virada',
      'date': '31 DEZ',
      'time': '22:00',
      'location': 'Templo Maior',
      'imageUrl': 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&q=80&w=1000',
      'description': 'Venha celebrar a chegada do novo ano na presença de Deus! Teremos muita música, oração e uma palavra profética para 2026.',
    },
    {
      'title': 'Conferência de Jovens',
      'date': '15 JAN',
      'time': '19:30',
      'location': 'Auditório Principal',
      'imageUrl': 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&q=80&w=1000',
      'description': 'Uma noite incrível de adoração e palavra voltada para a juventude. Não fique de fora!',
    }
  ];

  // Methods
  List<Map<String, String>> getDevotionals() {
    return List.from(_devotionals);
  }

  void addDevotional(Map<String, String> devotional) {
    _devotionals.insert(0, devotional); // Add to top
    print('DB: Devotional added: ${devotional['title']}');
  }

  List<Map<String, dynamic>> getEvents() => List.from(_events);


  final List<Map<String, dynamic>> _ministries = [
    {
      'id': '1',
      'name': 'Louvor',
      'iconCode': 0xe415, // music_note
      'colorValue': 0xFF9C27B0, // purple
      'leader': 'Carlos',
      'roles': ['Voz', 'Teclado', 'Bateria', 'Guitarra', 'Baixo'],
      'volunteers': [
        {'name': 'João Silva', 'role': 'Teclado'},
        {'name': 'Maria Oliveira', 'role': 'Voz'},
      ]
    },
    {
      'id': '2',
      'name': 'Ecclesia Kids',
      'iconCode': 0xe165, // child_care
      'colorValue': 0xFFFF9800, // orange
      'leader': 'Ana',
      'roles': ['Professor(a)', 'Auxiliar', 'Berçário', 'Check-in'],
      'volunteers': [
        {'name': 'Ana Costa', 'role': 'Professor(a)'},
      ]
    },
    {
      'id': '3',
      'name': 'Recepção',
      'iconCode': 0xe25b, // favorite
      'colorValue': 0xFFF44336, // red
      'leader': 'Beatriz',
      'roles': ['Porta Principal', 'Boas-vindas', 'Nave', 'Estacionamento'],
      'volunteers': []
    },
    {
      'id': '4',
      'name': 'Mídia',
      'iconCode': 0xe130, // camera_alt
      'colorValue': 0xFF2196F3, // blue
      'leader': 'Felipe',
      'roles': ['Câmera', 'Projeção', 'Fotografia', 'Transmissão'],
      'volunteers': []
    },
    {
      'id': '5',
      'name': 'Família',
      'iconCode': 0xe318, // house
      'colorValue': 0xFF4CAF50, // green
      'leader': 'Pr. Ricardo',
      'roles': ['Aconselhamento', 'Visitação', 'Casais'],
      'volunteers': []
    },
    {
      'id': '6',
      'name': 'Jovens',
      'iconCode': 0xe416, // music_video (simulated style)
      'colorValue': 0xFF000000, // black
      'leader': 'Lucas',
      'roles': ['Recepção', 'Louvor', 'Palavra', 'Social'],
      'volunteers': []
    },
     {
      'id': '7',
      'name': 'Juvenis',
      'iconCode': 0xe5f9, // skateboarding
      'colorValue': 0xFF795548, // brown
      'leader': 'Tiago',
      'roles': ['Monitor', 'Ensino', 'Games'],
      'volunteers': []
    },
    {
      'id': '8',
      'name': 'Teatro',
      'iconCode': 0xe628, // theater_comedy
      'colorValue': 0xFFE91E63, // pink
      'leader': 'Sarah',
      'roles': ['Ator/Atriz', 'Roteiro', 'Figurino', 'Maquiagem'],
      'volunteers': []
    },
  ];

  void addEvent(Map<String, dynamic> event) {
    _events.insert(0, event);
    print('DB: Event added: ${event['title']}');
  }

  // Ministries Methods
  List<Map<String, dynamic>> getMinistries() => _ministries;

  void addMinistry(Map<String, dynamic> ministry) {
    _ministries.add(ministry);
  }

  void updateMinistry(String id, String newName, String newLeader) {
    final index = _ministries.indexWhere((m) => m['id'] == id);
    if (index != -1) {
      _ministries[index]['name'] = newName;
      _ministries[index]['leader'] = newLeader;
    }
  }

  void addVolunteer(String ministryId, Map<String, String> volunteer) {
    final index = _ministries.indexWhere((m) => m['id'] == ministryId);
    if (index != -1) {
      // Must recreate list to ensure state updates if referenced directly
      final List<Map<String, String>> currentVolunteers = List.from(_ministries[index]['volunteers']);
      currentVolunteers.add(volunteer);
      _ministries[index]['volunteers'] = currentVolunteers;
    }
  }

  // Financial Methods
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': '1',
      'type': 'credit',
      'amount': 200.00,
      'description': 'Dízimo - Maria Silva',
      'category': 'Dízimo',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'method': 'Pix',
      'donor': 'Maria Silva'
    },
    {
      'id': '2',
      'type': 'debit',
      'amount': 400.00,
      'description': 'Conta de Luz',
      'category': 'Despesas',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'method': 'Boleto',
      'donor': null
    },
    {
      'id': '3',
      'type': 'credit',
      'amount': 1250.00,
      'description': 'Oferta Culto Domingo',
      'category': 'Oferta',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'method': 'Espécie',
      'donor': 'Anônimo'
    },
    {
      'id': '4',
      'type': 'credit',
      'amount': 5000.00,
      'description': 'Doação Reforma',
      'category': 'Doação',
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'method': 'Transferência',
      'donor': 'João Santos'
    },
    {
      'id': '5',
      'type': 'debit',
      'amount': 150.00,
      'description': 'Material Limpeza',
      'category': 'Despesas',
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'method': 'Cartão',
      'donor': null
    },
    {
      'id': '6',
      'type': 'credit',
      'amount': 150.00,
      'description': 'Dízimo - Pedro',
      'category': 'Dízimo',
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'method': 'Pix',
      'donor': 'Pedro'
    },
    {
      'id': '7',
      'type': 'debit',
      'amount': 1200.00,
      'description': 'Aluguel Som',
      'category': 'Equipamento',
      'date': DateTime.now().subtract(const Duration(days: 6)),
      'method': 'Pix',
      'donor': null
    },
     {
      'id': '8',
      'type': 'credit',
      'amount': 300.00,
      'description': 'Oferta Missionária',
      'category': 'Oferta',
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'method': 'Espécie',
      'donor': 'Anônimo'
    },
    {
      'id': '9',
      'type': 'credit',
      'amount': 100.00,
      'description': 'Cantina',
      'category': 'Vendas',
      'date': DateTime.now().subtract(const Duration(days: 0)), // Today
      'method': 'Pix',
      'donor': null
    },
    {
      'id': '10',
      'type': 'debit',
      'amount': 80.00,
      'description': 'Água Mineral',
      'category': 'Despesas',
      'date': DateTime.now(),
      'method': 'Espécie',
      'donor': null
    },
  ];

  List<Map<String, dynamic>> getTransactions() {
    // Return copy sorted by date desc
    final List<Map<String, dynamic>> sorted = List.from(_transactions);
    sorted.sort((a, b) => b['date'].compareTo(a['date']));
    return sorted;
  }

  void addTransaction(Map<String, dynamic> transaction) {
    _transactions.add(transaction);
  }

  // Leadership Requests
  final List<Map<String, String>> _leadershipRequests = [
    {
      'id': '1',
      'name': 'Carlos Eduardo',
      'role': 'Líder de Célula',
      'avatar': 'https://i.pravatar.cc/150?u=carlos',
      'status': 'pending', 
    },
    {
      'id': '2',
      'name': 'Fernanda Lima',
      'role': 'Líder de Ministério',
      'avatar': 'https://i.pravatar.cc/150?u=fernanda',
      'status': 'pending',
    },
    {
      'id': '3',
      'name': 'Roberto Junior',
      'role': 'Líder de Célula',
      'avatar': 'https://i.pravatar.cc/150?u=roberto',
      'status': 'pending',
    },
  ];

  List<Map<String, String>> getLeadershipRequests() => List.from(_leadershipRequests);

  void approveRequest(String id) {
    final index = _leadershipRequests.indexWhere((r) => r['id'] == id);
    if(index != -1) _leadershipRequests.removeAt(index);
  }

  void rejectRequest(String id) {
    final index = _leadershipRequests.indexWhere((r) => r['id'] == id);
    if(index != -1) _leadershipRequests.removeAt(index);
  }

  // Sermons Mock Data
  final List<Map<String, String>> _sermons = [
    {
      'id': '1',
      'title': 'A Cura da Ansiedade',
      'date': 'Domingo Passado',
      'thumbnail': 'https://images.unsplash.com/photo-1490730141103-6cac27aaab94?auto=format&fit=crop&q=80&w=800',
      'duration': '45:20',
    },
    {
      'id': '2',
      'title': 'Série: Gênesis - Parte 1',
      'date': '2 Semanas Atrás',
      'thumbnail': 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&q=80&w=800',
      'duration': '52:10',
    },
    {
      'id': '3',
      'title': 'Vencendo Gigantes',
      'date': '3 Semanas Atrás',
      'thumbnail': 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&q=80&w=800',
      'duration': '38:45',
    },
    {
      'id': '4',
      'title': 'O Poder do Perdão',
      'date': '1 Mês Atrás',
      'thumbnail': 'https://images.unsplash.com/photo-1507692049790-de58293a4697?auto=format&fit=crop&q=80&w=800',
      'duration': '41:30',
    },
  ];

  List<Map<String, String>> getSermons() => List.from(_sermons);

  // Bible Plans Mock Data
  final List<Map<String, dynamic>> _readingPlans = [
    {
      'title': 'Novo Testamento em 90 Dias',
      'image': 'https://images.unsplash.com/photo-1504052434569-70ad5836ab65?auto=format&fit=crop&q=80&w=400',
      'progress': 0.15,
      'days_total': 90,
      'days_completed': 13,
    },
    {
      'title': 'Salmos para Dormir',
      'image': 'https://images.unsplash.com/photo-1519817914152-22d216bb9170?auto=format&fit=crop&q=80&w=400',
      'progress': 0.0,
      'days_total': 30,
      'days_completed': 0,
    },
    {
      'title': 'Provérbios: Sabedoria Diária',
      'image': 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=400',
      'progress': 0.45,
      'days_total': 31,
      'days_completed': 14,
    },
  ];

  List<Map<String, dynamic>> getBiblePlans() => List.from(_readingPlans);
}
