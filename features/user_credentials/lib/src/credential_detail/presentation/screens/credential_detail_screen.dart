import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../credentials_list/domain/entities/verifiable_credential_entity.dart';
import '../../../credentials_list/presentation/screens/components/credential_card.dart';

class CredentialDetailScreen extends StatelessWidget {
  const CredentialDetailScreen({
    super.key,
    required this.credential,
    required this.isRevoking,
    required this.isAddingToWallet,
    this.onAddToWallet,
    this.onRevoke,
  });

  final VerifiableCredentialEntity credential;
  final bool isRevoking;
  final bool isAddingToWallet;
  final VoidCallback? onAddToWallet;
  final VoidCallback? onRevoke;

  @override
  Widget build(BuildContext context) {
    final canShowActions = credential.status != 'revoked';

    return Scaffold(
      appBar: const ValidAppBar(titleText: 'Detalhes'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'credential_card_${credential.credentialId}',
              child: CredentialCard(credential: credential),
            ),
            const SizedBox(height: 24),
            _buildPreviewSection(),
            if (canShowActions && onAddToWallet != null) ...[
              const SizedBox(height: 32),
              ValidButton(
                onPressed: onAddToWallet,
                label: 'Adicionar à Carteira do Google',
                isLoading: isAddingToWallet,
                icon: Image.asset('assets/images/icon/google-wallet-icon.png'),
              ),
            ],
            if (canShowActions && onRevoke != null) ...[
              const SizedBox(height: 16),
              ValidButton(
                label: 'Revogar Credencial',
                onPressed: onRevoke,
                isLoading: isRevoking,
                variant: ValidButtonVariant.secondary,
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewSection() {
    if (credential.preview.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informações',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...credential.preview.entries.map(
          (entry) =>
              _PreviewRow(label: entry.key, value: entry.value.toString()),
        ),
      ],
    );
  }
}

class _PreviewRow extends StatelessWidget {
  const _PreviewRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
