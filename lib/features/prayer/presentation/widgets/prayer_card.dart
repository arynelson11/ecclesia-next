import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_theme.dart';

class PrayerCard extends StatefulWidget {
  final String authorName;
  final String authorAvatarUrl;
  final String timeAgo;
  final String content;
  final String category;
  final int initialPrayerCount;

  const PrayerCard({
    super.key,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.timeAgo,
    required this.content,
    required this.category,
    required this.initialPrayerCount,
  });

  @override
  State<PrayerCard> createState() => _PrayerCardState();
}

class _PrayerCardState extends State<PrayerCard> {
  bool _hasPrayed = false;
  late int _prayerCount;

  @override
  void initState() {
    super.initState();
    _prayerCount = widget.initialPrayerCount;
  }

  void _onPray() {
    setState(() {
      _hasPrayed = !_hasPrayed;
      _prayerCount += _hasPrayed ? 1 : -1;
    });
    // Add haptic feedback/vibration here if desired
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [AppTheme.kSoftShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.authorAvatarUrl),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.authorName,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                  Text(
                    widget.timeAgo,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(widget.category).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.category,
                  style: TextStyle(
                    color: _getCategoryColor(widget.category),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Content
          Text(
            widget.content,
            style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
          ),
          
          const SizedBox(height: 16),
          Divider(color: Colors.grey[100], height: 1),
          const SizedBox(height: 12),
          
          // Action
          GestureDetector(
            onTap: _onPray,
            child: Row(
              mainAxisSize: MainAxisSize.min, // shrink wrap to click area
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _hasPrayed ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.volunteer_activism_rounded, 
                    size: 20, 
                    color: _hasPrayed ? Colors.blue : Colors.grey[400]
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$_prayerCount oraram',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _hasPrayed ? Colors.blue : Colors.grey[500],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'saúde': return Colors.red;
      case 'família': return Colors.orange;
      case 'emprego': return Colors.green;
      default: return Colors.blue;
    }
  }
}
