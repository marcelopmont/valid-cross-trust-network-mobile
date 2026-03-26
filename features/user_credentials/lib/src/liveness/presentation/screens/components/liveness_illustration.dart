import 'package:flutter/material.dart';

class LivenessIllustration extends StatelessWidget {
  const LivenessIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: const Icon(Icons.face_retouching_natural, size: 64),
    );
  }
}
