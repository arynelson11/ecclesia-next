import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/bento_skeleton_card.dart';
import '../../../../features/prayer/presentation/pages/prayer_wall_page.dart';
import '../../../../features/events/presentation/pages/events_list_page.dart';
import '../cubit/content_cubit.dart';
import '../widgets/devotional_card.dart';

class MemberHomePage extends StatelessWidget {
  const MemberHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildCategories(),
              const SizedBox(height: 32),
              
              const Text(
                'Destaque da Semana',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black, letterSpacing: -0.5),
              ),
              const SizedBox(height: 16),

              // HERO CARD (16:9)
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1438232992991-995b7058bbb3?auto=format&fit=crop&q=80&w=1000'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: const [AppTheme.kSoftShadow],
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                          stops: const [0.4, 1.0],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text('AO VIVO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Culto da Família',
                            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900),
                          ),
                          const Text(
                            'Domingo às 10h • Templo Maior',
                            style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Últimos Devocionais',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black, letterSpacing: -0.5),
              ),
              const SizedBox(height: 16),
              
              // DYNAMIC LIST
              BlocBuilder<ContentCubit, ContentState>(
                builder: (context, state) {
                  if (state is ContentLoading) {
                    return Column(children: const [BentoSkeletonCard(height: 120), SizedBox(height: 16), BentoSkeletonCard(height: 120)]);
                  } else if (state is ContentLoaded) {
                    if (state.devotionals.isEmpty) {
                       return Container(
                         padding: const EdgeInsets.all(32),
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(24),
                         ),
                         child: Column(
                            children: const [
                              Icon(Icons.coffee_rounded, size: 48, color: Colors.grey),
                              SizedBox(height: 16),
                              Text("Nenhuma novidade hoje...", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                            ],
                         ),
                       );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.devotionals.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return _buildSimplelistCard(context, state.devotionals[index]);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimplelistCard(BuildContext context, Map<String, String> data) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [AppTheme.kSoftShadow],
      ),
      child: Row(
        children: [
          // Image Left
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
            child: Image.network(
              data['imageUrl'] ?? '',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (_,__,___) => Container(width: 120, height: 120, color: Colors.grey[200]),
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Chip
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      data['category'] ?? 'GERAL',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data['title'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, height: 1.1),
                  ),
                ],
              ),
            ),
          ),
           Padding(
             padding: const EdgeInsets.only(right: 16),
             child: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[400]),
           ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
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
                     decoration: const InputDecoration(
                       hintText: 'Buscar...',
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
        const SizedBox(width: 16),
        CircleAvatar(
          radius: 25,
          backgroundImage: const NetworkImage('https://i.pravatar.cc/300'),
          backgroundColor: Colors.grey[200],
        ),
      ],
    );
  }

  Widget _buildCategories() {
    final categories = ['Todos', 'Pregações', 'Eventos', 'Orações'];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return GestureDetector(
            onTap: () {
               if (categories[index] == 'Orações') {
                 Navigator.push(context, MaterialPageRoute(builder: (_) => const PrayerWallPage()));
               } else if (categories[index] == 'Eventos') {
                 Navigator.push(context, MaterialPageRoute(builder: (_) => const EventsListPage()));
               } else if (categories[index] == 'Pregações') {
                 Navigator.pushNamed(context, '/sermons');
               }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: isSelected ? null : Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
