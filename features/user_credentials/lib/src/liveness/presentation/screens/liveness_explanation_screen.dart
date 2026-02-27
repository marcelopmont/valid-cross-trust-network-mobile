import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'components/liveness_agree_button.dart';
import 'components/liveness_cancel_button.dart';
import 'components/liveness_illustration.dart';

class LivenessExplanationScreen extends StatelessWidget {
  const LivenessExplanationScreen({
    super.key,
    required this.onAgree,
    required this.onCancel,
    required this.isLoading,
  });

  final VoidCallback onAgree;
  final VoidCallback onCancel;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Verificação de Identidade'),
        backgroundColor: AppColors.darkBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onCancel,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 24),
              const LivenessIllustration(),
              const SizedBox(height: 32),
              const Text(
                'Verificação de Liveness',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Para garantir sua segurança e confirmar sua identidade, '
                'precisamos realizar uma verificação facial rápida.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.grey,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              LivenessAgreeButton(onPressed: onAgree, isLoading: isLoading),
              const SizedBox(height: 12),
              LivenessCancelButton(onPressed: onCancel, isLoading: isLoading),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
