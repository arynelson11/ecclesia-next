import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../pages/devotional_detail_page.dart';

class DevotionalCard extends StatelessWidget {
  final Map<String, String> data;

  const DevotionalCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final category = data['category']?.toUpperCase() ?? 'GERAL';
    
    // Dynamic Category Color based on text hash
    final Color categoryColor = _getCategoryColor(category);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DevotionalDetailPage(devotionalData: data),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.kRadius),
          boxShadow: const [AppTheme.kSoftShadow],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.kRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 10,
                    child: data['imageUrl'] != null && data['imageUrl']!.isNotEmpty
                        ? Image.network(
                            data['imageUrl']!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(color: Colors.grey[100], child: const Icon(Icons.image_not_supported, color: Colors.grey)),
                          )
                        : Container(color: Colors.grey[100], child: const Icon(Icons.church_outlined, size: 40, color: Colors.grey)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: categoryColor.withValues(alpha: 0.1), // Tinted Background
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            category,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: categoryColor, // Colored Text
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.bookmark_border_rounded, color: Colors.black45, size: 24),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      data['title'] ?? 'Sem Título',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      data['summary'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ler agora',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.black, 
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    if (category.contains('JOVENS')) return Colors.orange;
    if (category.contains('FÉ') || category.contains('VIDA')) return Colors.blue;
    if (category.contains('ESPIRITUAL')) return Colors.purple;
    if (category.contains('FAMÍLIA')) return Colors.green;
    return Colors.grey[700]!;
  }
}
