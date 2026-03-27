import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/offer_entity.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.offer,
    required this.isIssuing,
    required this.onEmit,
  });

  final OfferEntity offer;
  final bool isIssuing;
  final VoidCallback onEmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizedCredentialType(
              l10n,
              offer.credentialType,
            ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  offer.issuer.name,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ValidButton(
                label: l10n.issue,
                size: ValidButtonSize.small,
                width: 100,
                onPressed: isIssuing ? null : onEmit,
                isLoading: isIssuing,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
