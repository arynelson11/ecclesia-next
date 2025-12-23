import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/data/mock_database.dart';

// --- LIST PAGE ---
class EventsListPage extends StatelessWidget {
  const EventsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final events = MockDatabase().getEvents();

    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('PRÓXIMOS EVENTOS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          // Month Filter
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                _buildFilterChip('Dezembro', true),
                const SizedBox(width: 12),
                _buildFilterChip('Janeiro', false),
                const SizedBox(width: 12),
                _buildFilterChip('Fevereiro', false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: events.length,
              separatorBuilder: (_, __) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
                return _EventHeroCard(event: events[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: isSelected ? null : Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _EventHeroCard extends StatelessWidget {
  final Map<String, dynamic> event;
  const _EventHeroCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EventDetailsPage(event: event))),
      child: Container(
        height: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [AppTheme.kSoftShadow],
        ),
        child: Column(
          children: [
            // Image Half
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                    child: Image.network(
                      event['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (_,__,___) => Container(color: Colors.grey[300]),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            event['date'].split(' ')[0],
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                          ),
                          Text(
                            event['date'].split(' ')[1],
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content Half
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time_rounded, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(event['time'], style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 16),
                            const Icon(Icons.location_on_rounded, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(event['location'], style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Entrada Gratuita', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('Ver Detalhes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- DETAILS PAGE ---
class EventDetailsPage extends StatelessWidget {
  final Map<String, dynamic> event;
  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black, // Back button color
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                event['imageUrl'], 
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.2), // Dim for contrast back button
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  event['title'],
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -1.0, height: 1.1),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildInfoItem(Icons.calendar_month_rounded, event['date']),
                    const SizedBox(width: 24),
                    _buildInfoItem(Icons.access_time_rounded, event['time']),
                    const SizedBox(width: 24),
                    _buildInfoItem(Icons.location_on_rounded, event['location']),
                  ],
                ),
                const SizedBox(height: 32),
                const Text('Sobre o evento', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 12),
                Text(
                  event['description'] ?? 'Sem descrição.',
                  style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black54),
                ),
                 const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [AppTheme.kSoftShadow],
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (_) => const EventTicketPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('CONFIRMAR PRESENÇA', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
          child: Icon(icon, size: 18, color: Colors.black),
        ),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
      ],
    );
  }
}

// --- TICKET PAGE ---
class EventTicketPage extends StatelessWidget {
  const EventTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark Immersive
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text('SEU INGRESSO', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Part
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle_rounded, color: Colors.green, size: 48),
                      const SizedBox(height: 16),
                      const Text('Confirmado!', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: Colors.black)),
                      const SizedBox(height: 8),
                      const Text('Apresente este código na entrada', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 32),
                      Container(
                        height: 200,
                        width: 200,
                        color: Colors.black, // QR Placeholder
                        alignment: Alignment.center,
                        child: const Icon(Icons.qr_code_2_rounded, color: Colors.white, size: 100),
                      ),
                      const SizedBox(height: 16),
                      const Text('TICKET #849201', style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 2)),
                    ],
                  ),
                ),
                // Dashed Line (Simulated)
                Row(
                  children: List.generate(30, (index) => Expanded(
                    child: Container(
                      height: 2, 
                      color: index % 2 == 0 ? Colors.grey[300] : Colors.transparent
                    ),
                  )),
                ),
                // Bottom Info
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       _buildTicketInfo('DATA', '31 DEZ'),
                       _buildTicketInfo('HORA', '22:00'),
                       _buildTicketInfo('LOCAL', 'Templo'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black)),
      ],
    );
  }
}
