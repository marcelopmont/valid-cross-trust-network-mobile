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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ValidAppBar(
        titleText: l10n.identityVerification,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onCancel,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 24),
              const LivenessIllustration(),
              const SizedBox(height: 32),
              Text(
                l10n.livenessVerification,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.livenessDescription,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              LivenessAgreeButton(
                onPressed: onAgree,
                isLoading: isLoading,
              ),
              const SizedBox(height: 12),
              LivenessCancelButton(
                onPressed: onCancel,
                isLoading: isLoading,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
