import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LivenessCancelButton extends StatelessWidget {
  const LivenessCancelButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return TextButton(
      onPressed: isLoading ? null : onPressed,
      child: Text(
        l10n.cancel,
        style: TextStyle(
          fontSize: 16,
          color: isLoading ? Colors.grey : Colors.grey[600],
        ),
      ),
    );
  }
}
