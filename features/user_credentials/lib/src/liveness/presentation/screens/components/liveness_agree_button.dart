import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LivenessAgreeButton extends StatelessWidget {
  const LivenessAgreeButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ValidButton(
      label: l10n.startVerification,
      onPressed: isLoading ? null : onPressed,
      isLoading: isLoading,
    );
  }
}
