import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LivenessIllustration extends StatelessWidget {
  const LivenessIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: AppColors.darkBlue.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.face_retouching_natural,
        size: 64,
        color: AppColors.darkBlue,
      ),
    );
  }
}
