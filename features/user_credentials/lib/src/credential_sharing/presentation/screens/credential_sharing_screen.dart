import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../credentials_list/domain/entities/verifiable_credential_entity.dart';
import '../../domain/entities/verifier_request_entity.dart';

class CredentialSharingScreen extends StatelessWidget {
  const CredentialSharingScreen({
    super.key,
    required this.verifierRequest,
    required this.matchingCredentials,
    required this.selectedCredential,
    required this.isSubmitting,
    required this.onSelectCredential,
    required this.onConfirm,
    required this.onCancel,
  });

  final VerifierRequestEntity? verifierRequest;
  final List<VerifiableCredentialEntity> matchingCredentials;
  final VerifiableCredentialEntity? selectedCredential;
  final bool isSubmitting;
  final void Function(VerifiableCredentialEntity) onSelectCredential;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (verifierRequest == null) {
      return Scaffold(
        appBar: ValidAppBar(titleText: l10n.shareCredential),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final request = verifierRequest!;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: ValidAppBar(
        titleText: l10n.shareCredential,
        leading: IconButton(icon: const Icon(Icons.close), onPressed: onCancel),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.verified_user_outlined,
                size: 56,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.verificationPurpose,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                request.purpose,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.requestedFields,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: request.requestedFields
                      .map(
                        (field) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                size: 18,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  field,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.selectCredential,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              if (matchingCredentials.isEmpty)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    l10n.noActiveCredentials,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: matchingCredentials.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final credential = matchingCredentials[index];
                      final isSelected = credential == selectedCredential;
                      return _CredentialCard(
                        credential: credential,
                        isSelected: isSelected,
                        onTap: () => onSelectCredential(credential),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              ValidButton(
                label: l10n.confirmSharing,
                onPressed: selectedCredential != null && !isSubmitting
                    ? onConfirm
                    : null,
                isLoading: isSubmitting,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: isSubmitting ? null : onCancel,
                child: Text(l10n.cancel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CredentialCard extends StatelessWidget {
  const _CredentialCard({
    required this.credential,
    required this.isSelected,
    required this.onTap,
  });

  final VerifiableCredentialEntity credential;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    credential.credentialType,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    credential.issuer.name,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
