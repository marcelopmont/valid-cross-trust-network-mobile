import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../domain/entities/verifiable_credential_entity.dart';
import 'credential_status_badge.dart';

class CredentialCard extends StatelessWidget {
  const CredentialCard({
    super.key,
    required this.credential,
    this.isAddingToWallet = false,
    this.onAddWallet,
  });

  final VerifiableCredentialEntity credential;
  final bool isAddingToWallet;
  final VoidCallback? onAddWallet;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: onAddWallet != null ? 260 : 200,
      borderRadius: 16,
      blur: 40, // Muito mais fosco
      alignment: Alignment.center,
      border: 1.5,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.primary.withValues(alpha: 0.75),
          AppColors.accent.withValues(alpha: 0.55),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.5),
          Colors.white.withValues(alpha: 0.1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    credential.credentialType,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                CredentialStatusBadge(status: credential.status),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              credential.issuer.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Emitido em: ${_formatDate(credential.issuedAt)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            if (credential.expiresAt != null) ...[
              const SizedBox(height: 4),
              Text(
                'Expira em: ${_formatDate(credential.expiresAt!)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
            if (onAddWallet != null) ...[
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: isAddingToWallet
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : GestureDetector(
                        onTap: onAddWallet,
                        child: Image.asset(
                          'assets/images/add_to_google_wallet.png',
                          height: 24,
                        ),
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (_) {
      return isoDate;
    }
  }
}
