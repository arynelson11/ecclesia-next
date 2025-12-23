import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class MinistriesPage extends StatelessWidget {
  const MinistriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data for "Category Grid"
    final List<Map<String, dynamic>> ministries = [
      {'name': 'Louvor', 'icon': Icons.music_note_rounded, 'color': Colors.blue},
      {'name': 'Kids', 'icon': Icons.child_care_rounded, 'color': Colors.orange},
      {'name': 'Diaconia', 'icon': Icons.volunteer_activism_rounded, 'color': Colors.red},
      {'name': 'Mídia', 'icon': Icons.video_camera_back_rounded, 'color': Colors.purple},
      {'name': 'Missões', 'icon': Icons.public_rounded, 'color': Colors.green},
      {'name': 'Teatro', 'icon': Icons.theater_comedy_rounded, 'color': Colors.teal},
      {'name': 'Recepção', 'icon': Icons.people_outline_rounded, 'color': Colors.amber},
      {'name': 'Ensino', 'icon': Icons.menu_book_rounded, 'color': Colors.indigo},
    ];

    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        leading: IconButton(
           icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
           onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'MINISTÉRIOS',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0, // Square Tiles
          ),
          itemCount: ministries.length,
          itemBuilder: (context, index) {
            final ministry = ministries[index];
            return Material(
              color: Colors.transparent, // For ripple on inkwell
              child: InkWell(
                onTap: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gerenciar ${ministry['name']}')),
                   );
                },
                borderRadius: BorderRadius.circular(AppTheme.kRadius),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppTheme.kRadius), // Radius 30
                    boxShadow: const [AppTheme.kSoftShadow],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: (ministry['color'] as Color).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          ministry['icon'] as IconData,
                          size: 32,
                          color: ministry['color'] as Color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        ministry['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                       const Text(
                        '12 Membros',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
