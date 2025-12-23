import 'package:flutter/material.dart';

class HomeStoriesBar extends StatelessWidget {
  final List<Map<String, String?>> stories;

  const HomeStoriesBar({
    super.key,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return SizedBox(
      height: 120, // Aumentado para evitar overflow
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final story = stories[index];
          final isUnseen = index < 2; // Mock: primeiros 2 não vistos

          return Column(
            children: [
              // Avatar Circular com Borda (Stories Ring)
              Container(
                padding: const EdgeInsets.all(3), // Espaço para o anel
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isUnseen
                      ? Border.all(color: primaryColor, width: 2)
                      : Border.all(color: Colors.grey[300]!, width: 2),
                ),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    image: story['imageUrl'] != null
                        ? DecorationImage(
                            image: NetworkImage(story['imageUrl']!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: story['imageUrl'] == null
                      ? Icon(Icons.campaign, color: Colors.grey[400])
                      : null,
                ),
              ),
              const SizedBox(height: 6),
              
              // Texto curto
              SizedBox(
                width: 70,
                child: Text(
                  story['title'] ?? '',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: isUnseen ? FontWeight.bold : FontWeight.normal,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
