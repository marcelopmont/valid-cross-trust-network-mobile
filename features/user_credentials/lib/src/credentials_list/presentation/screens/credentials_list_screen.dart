import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/verifiable_credential_entity.dart';
import 'components/credentials_empty_state.dart';
import 'components/credentials_list.dart';

class CredentialsListScreen extends StatelessWidget {
  const CredentialsListScreen({
    super.key,
    required this.isLoading,
    required this.credentials,
    required this.hasReachedEnd,
    required this.onAddCredential,
    required this.onLoadMore,
    this.issuingWalletCredentialId,
    this.onAddWallet,
    this.onCredentialTap,
    this.userDocument,
    this.onLogout,
  });

  final bool isLoading;
  final List<VerifiableCredentialEntity> credentials;
  final bool hasReachedEnd;
  final VoidCallback onAddCredential;
  final VoidCallback onLoadMore;
  final String? issuingWalletCredentialId;
  final void Function(String)? onAddWallet;
  final void Function(VerifiableCredentialEntity)?
      onCredentialTap;
  final String? userDocument;
  final VoidCallback? onLogout;

  String _formatDocument(String document) {
    if (document.length == 11) {
      return '${document.substring(0, 3)}'
          '.${document.substring(3, 6)}'
          '.${document.substring(6, 9)}'
          '-${document.substring(9)}';
    }
    return document;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.cpfLabel,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[500],
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userDocument != null
                            ? _formatDocument(
                                userDocument!)
                            : '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onLogout,
                    icon: Icon(
                      Icons.logout_outlined,
                      size: 22,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _buildBody()),
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 96,
                top: 8,
              ),
              child: ValidButton(
                label: l10n.addCredential,
                icon: Icons.add,
                color: AppColors.accent,
                onPressed: onAddCredential,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    Widget content;

    if (isLoading && credentials.isEmpty) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (credentials.isEmpty) {
      content = const CredentialsEmptyState();
    } else {
      content = CredentialsList(
        credentials: credentials,
        isLoading: isLoading,
        hasReachedEnd: hasReachedEnd,
        onLoadMore: onLoadMore,
        issuingWalletCredentialId:
            issuingWalletCredentialId,
        onAddWallet: onAddWallet,
        onCredentialTap: onCredentialTap,
      );
    }

    return content;
  }
}
