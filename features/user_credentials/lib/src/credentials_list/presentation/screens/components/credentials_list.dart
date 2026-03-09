import 'package:flutter/material.dart';

import '../../../domain/entities/verifiable_credential_entity.dart';
import 'credential_card.dart';

class CredentialsList extends StatelessWidget {
  const CredentialsList({
    super.key,
    required this.credentials,
    required this.isLoading,
    required this.hasReachedEnd,
    required this.onLoadMore,
  });

  final List<VerifiableCredentialEntity> credentials;
  final bool isLoading;
  final bool hasReachedEnd;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!isLoading &&
            !hasReachedEnd &&
            scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 200) {
          onLoadMore();
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: credentials.length + (hasReachedEnd ? 0 : 1),
        itemBuilder: (context, index) {
          if (index >= credentials.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CredentialCard(credential: credentials[index]),
          );
        },
      ),
    );
  }
}
