import 'package:core/core.dart';
import 'package:flutter/material.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({
    super.key,
    required this.isLoading,
    required this.userDocument,
    required this.onLogout,
  });

  final bool isLoading;
  final String? userDocument;
  final VoidCallback onLogout;

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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.person,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ? _formatDocument(userDocument!)
                                  : l10n.documentNotFound,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: onLogout,
                      icon: Icon(
                        Icons.logout_outlined,
                        size: 20,
                        color: Colors.grey[700],
                      ),
                      label: Text(
                        l10n.signOut,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
      ),
    );
  }
}
