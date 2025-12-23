import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BentoSkeletonCard extends StatefulWidget {
  final double height;
  const BentoSkeletonCard({super.key, this.height = 200});

  @override
  State<BentoSkeletonCard> createState() => _BentoSkeletonCardState();
}

class _BentoSkeletonCardState extends State<BentoSkeletonCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.kRadius),
        boxShadow: const [AppTheme.kSoftShadow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.kRadius),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: const [
                    Color(0xFFEEEEEE),
                    Color(0xFFFAFAFA),
                    Color(0xFFEEEEEE),
                  ],
                  stops: const [0.1, 0.5, 0.9],
                  transform: GradientRotation(0.0), // No rotation needed
                ).createShader(
                   Rect.fromLTWH(
                     rect.width * _animation.value, 
                     0, 
                     rect.width, 
                     rect.height
                   ),
                );
              },
              blendMode: BlendMode.srcATop,
              child: Container(
                decoration: const BoxDecoration(color: Color(0xFFEEEEEE)), // Base grey
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: widget.height * 0.6, color: Colors.white), // Image placeholder area (lighter)
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 12, width: 80, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6))),
                          const SizedBox(height: 16),
                          Container(height: 24, width: 200, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))),
                          const SizedBox(height: 12),
                          Container(height: 12, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
