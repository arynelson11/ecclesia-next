import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/data/mock_database.dart';

class BiblePlansPage extends StatelessWidget {
  const BiblePlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = MockDatabase().getBiblePlans();
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('PLANOS DE LEITURA', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.5, color: Colors.black54)),
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
            // Hero: My Progress
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black, // Dark for contrast
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [AppTheme.kSoftShadow],
              ),
              child: Row(
                children: [
                   SizedBox(
                     height: 100, width: 100,
                     child: Stack(
                       alignment: Alignment.center,
                       children: [
                         const SizedBox(
                           height: 100, width: 100,
                           child: CircularProgressIndicator(value: 0.45, strokeWidth: 8, color: Colors.white, backgroundColor: Colors.white24),
                         ),
                         Column(
                           mainAxisSize: MainAxisSize.min,
                           children: const [
                             Text('45%', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                             Text('Lido', style: TextStyle(color: Colors.white70, fontSize: 10)),
                           ],
                         ),
                       ],
                     ),
                   ),
                   const SizedBox(width: 24),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text('Bíblia em 1 Ano', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                         const SizedBox(height: 8),
                         const Text('Você está indo bem! Continue assim para atingir a meta.', style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
                         const SizedBox(height: 16),
                         // Streak
                         Row(
                           children: const [
                             Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
                             SizedBox(width: 4),
                             Text('5 dias seguidos', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
                           ],
                         )
                       ],
                     ),
                   )
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Today's Reading
            const Text('Leitura de Hoje', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [AppTheme.kSoftShadow],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Salmos 23', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                          SizedBox(height: 4),
                          Text('O Senhor é meu pastor...', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Icon(Icons.book, size: 40, color: Colors.black12),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Abrindo leitura...')));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('LER AGORA', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
             const SizedBox(height: 32),

            // Plan Catalog
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Explorar Planos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton(onPressed: (){}, child: const Text('Ver todos')),
              ],
            ),
            const SizedBox(height: 16),
            
            SizedBox(
              height: 240,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: plans.length,
                separatorBuilder: (_,__) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final plan = plans[index];
                  return Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [AppTheme.kSoftShadow],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                              image: DecorationImage(image: NetworkImage(plan['image']), fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(plan['title'], maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                LinearProgressIndicator(value: plan['progress'], backgroundColor: Colors.grey[100], color: primaryColor, borderRadius: BorderRadius.circular(2)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
