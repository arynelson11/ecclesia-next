import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/data/mock_database.dart';

class SermonsPage extends StatelessWidget {
  const SermonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sermons = MockDatabase().getSermons();
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('PREGAÇÕES', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.5, color: Colors.black54)),
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
            // Live Banner
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1510915361894-db8b60106cb1?auto=format&fit=crop&q=80&w=1000'),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [AppTheme.kSoftShadow],
              ),
              child: Stack(
                children: [
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       color: Colors.black.withOpacity(0.4),
                     ),
                   ),
                   Positioned(
                     top: 16, left: 16,
                     child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                       decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                       child: Row(
                         children: const [
                           Icon(Icons.circle, size: 10, color: Colors.white),
                           SizedBox(width: 8),
                           Text('AO VIVO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                         ],
                       ),
                     ),
                   ),
                   Center(
                     child: IconButton(
                       icon: const Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
                       onPressed: () => _openPlayer(context, 'Culto de Domingo - Ao Vivo', true),
                     ),
                   ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            const Text('Mensagens Recentes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Full width cards look more like YT mobile
                childAspectRatio: 1.6,
                mainAxisSpacing: 24,
              ),
              itemCount: sermons.length,
              itemBuilder: (context, index) {
                final sermon = sermons[index];
                return GestureDetector(
                  onTap: () => _openPlayer(context, sermon['title']!, false),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(image: NetworkImage(sermon['thumbnail']!), fit: BoxFit.cover),
                            boxShadow: const [AppTheme.kSoftShadow],
                          ),
                          child: Stack(
                            children: [
                               Positioned(
                                 bottom: 12, right: 12,
                                 child: Container(
                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                   decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(4)),
                                   child: Text(sermon['duration']!, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                 ),
                               )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                             backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=pastor'),
                             radius: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(sermon['title']!, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 1.2)),
                                const SizedBox(height: 4),
                                Text('Pr. Ricardo • ${sermon['date']}', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                              ],
                            ),
                          ),
                          IconButton(icon: const Icon(Icons.more_vert), onPressed: (){}),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openPlayer(BuildContext context, String title, bool isLive) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SermonPlayerPage(title: title, isLive: isLive)));
  }
}

class SermonPlayerPage extends StatelessWidget {
  final String title;
  final bool isLive;
  const SermonPlayerPage({super.key, required this.title, required this.isLive});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
             // Fake Video Player
             Container(
               height: 250,
               width: double.infinity,
               color: Colors.grey[900],
               child: Stack(
                 alignment: Alignment.center,
                 children: [
                   const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 80),
                   if (isLive)
                     Positioned(
                       top: 16, left: 16,
                       child: Container(
                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                         decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                         child: const Text('AO VIVO', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                       ),
                     ),
                    Positioned(
                       bottom: 10, left: 10, right: 10,
                       child: Column(
                         children: [
                           Container(height: 4, width: double.infinity, color: Colors.red),
                           const SizedBox(height: 8),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: const [
                               Text('0:00 / 45:00', style: TextStyle(color: Colors.white)),
                               Icon(Icons.fullscreen, color: Colors.white),
                             ],
                           ),
                         ],
                       ),
                    ),
                 ],
               ),
             ),
             Expanded(
               child: Container(
                 color: Colors.white,
                 padding: const EdgeInsets.all(24),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 8),
                     Row(
                       children: [
                         const Text('2,4 mil visualizações', style: TextStyle(color: Colors.grey)),
                         const SizedBox(width: 16),
                         Text(isLive ? 'Transmitindo agora' : 'há 2 dias', style: const TextStyle(color: Colors.grey)),
                       ],
                     ),
                     const SizedBox(height: 24),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         _buildAction(Icons.thumb_up_outlined, 'Curtir'),
                         _buildAction(Icons.share_outlined, 'Compartilhar'),
                         _buildAction(Icons.save_alt_outlined, 'Salvar'),
                         _buildAction(Icons.flag_outlined, 'Reportar'),
                       ],
                     ),
                     const Divider(height: 48),
                     const Text('Próximos vídeos', style: TextStyle(fontWeight: FontWeight.bold)),
                     // List of next videos...
                   ],
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAction(IconData icon, String label) {
    return Column(children: [Icon(icon), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 12))]);
  }
}
