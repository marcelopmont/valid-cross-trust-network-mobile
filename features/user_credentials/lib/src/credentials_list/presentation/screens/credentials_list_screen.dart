import 'package:flutter/material.dart';
import 'package:core/core.dart';

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
  });

  final bool isLoading;
  final List<VerifiableCredentialEntity> credentials;
  final bool hasReachedEnd;
  final VoidCallback onAddCredential;
  final VoidCallback onLoadMore;
  final String? issuingWalletCredentialId;
  final void Function(String)? onAddWallet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const ValidAppBar(titleText: 'Carteira'),
      body: _buildBody(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0), // height of bottom navbar
        child: ValidFloatingActionButton(
          onPressed: onAddCredential,
          icon: Icons.add,
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading && credentials.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (credentials.isEmpty) {
      return const CredentialsEmptyState();
    }

    return CredentialsList(
      credentials: credentials,
      isLoading: isLoading,
      hasReachedEnd: hasReachedEnd,
      onLoadMore: onLoadMore,
      issuingWalletCredentialId: issuingWalletCredentialId,
      onAddWallet: onAddWallet,
    );
  }
}
