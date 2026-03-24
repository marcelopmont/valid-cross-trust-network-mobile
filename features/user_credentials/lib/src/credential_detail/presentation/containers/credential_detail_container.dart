import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../bloc/credential_detail_bloc.dart';
import '../bloc/credential_detail_event.dart';
import '../bloc/credential_detail_state.dart';
import '../screens/credential_detail_screen.dart';

class CredentialDetailContainer
    extends BlocConsumer<CredentialDetailBloc, CredentialDetailState> {
  CredentialDetailContainer({super.key, required this.onRevoked})
    : super(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Erro ao revogar credencial'),
              ),
            );
          }
          if (state.isRevoked) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Credencial revogada com sucesso'),
              ),
            );
            onRevoked(state.credential);
          }
        },
        builder: (context, state) {
          return CredentialDetailScreen(
            credential: state.credential,
            isRevoking: state.isRevoking,
            onRevoke: state.credential.status != 'revoked'
                ? () {
                    CredentialDetailBlocProvider.of(
                      context,
                    ).add(const RevokeCredential());
                  }
                : null,
          );
        },
      );

  final void Function(dynamic credential) onRevoked;
}
