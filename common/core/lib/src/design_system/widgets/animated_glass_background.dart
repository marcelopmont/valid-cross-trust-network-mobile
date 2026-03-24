import 'dart:ui';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class AnimatedGlassBackground extends StatefulWidget {
  const AnimatedGlassBackground({super.key});

  @override
  State<AnimatedGlassBackground> createState() => _AnimatedGlassBackgroundState();
}

class _AnimatedGlassBackgroundState extends State<AnimatedGlassBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Basic static gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE5E7EB), // Very light grey base
                  Color(0xFFF3F4F6),
                ],
              ),
            ),
          ),
          
          // Blob 1 Primary Color
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Align(
                alignment: Alignment(
                  -0.8 + (_controller.value * 0.5),
                  -0.6 + (_controller.value * 1.2),
                ),
                child: child,
              );
            },
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.15),
              ),
            ),
          ),

          // Blob 2 Accent Color
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Align(
                alignment: Alignment(
                  0.8 - (_controller.value * 0.4),
                  0.5 - (_controller.value * 1.5),
                ),
                child: child,
              );
            },
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withValues(alpha: 0.15),
              ),
            ),
          ),

          // Blob 3 Light Primary
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Align(
                alignment: Alignment(
                  0.2 + (_controller.value * 0.8),
                  0.9 - (_controller.value * 0.3),
                ),
                child: child,
              );
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
          ),

          // Intense overall blur to blend the colors into a mesh gradient look
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}
