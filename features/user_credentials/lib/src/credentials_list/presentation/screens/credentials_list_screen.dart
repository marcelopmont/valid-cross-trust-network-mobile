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
  });

  final bool isLoading;
  final List<VerifiableCredentialEntity> credentials;
  final bool hasReachedEnd;
  final VoidCallback onAddCredential;
  final VoidCallback onLoadMore;
  final String? issuingWalletCredentialId;
  final void Function(String)? onAddWallet;
  final void Function(VerifiableCredentialEntity)? onCredentialTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const ValidAppBar(titleText: 'Carteira'),
      body: _buildBody(),
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 80.0,
          ), // height of bottom navbar
          child: ValidFloatingActionButton(
            onPressed: onAddCredential,
            icon: Icons.add,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    Widget content;

    if (isLoading && credentials.isEmpty) {
      content = const Center(child: CircularProgressIndicator());
    } else if (credentials.isEmpty) {
      content = const CredentialsEmptyState();
    } else {
      content = CredentialsList(
        credentials: credentials,
        isLoading: isLoading,
        hasReachedEnd: hasReachedEnd,
        onLoadMore: onLoadMore,
        issuingWalletCredentialId: issuingWalletCredentialId,
        onAddWallet: onAddWallet,
        onCredentialTap: onCredentialTap,
      );
    }

    return content;
  }
}
