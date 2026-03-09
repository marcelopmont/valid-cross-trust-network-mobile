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
  });

  final bool isLoading;
  final List<VerifiableCredentialEntity> credentials;
  final bool hasReachedEnd;
  final VoidCallback onAddCredential;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carteira'),
        backgroundColor: AppColors.darkBlue,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddCredential,
        backgroundColor: AppColors.darkBlue,
        child: const Icon(Icons.add, color: Colors.white),
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
    );
  }
}
