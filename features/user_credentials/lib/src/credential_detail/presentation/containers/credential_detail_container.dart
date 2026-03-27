import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../bloc/credential_detail_bloc.dart';
import '../bloc/credential_detail_event.dart';
import '../bloc/credential_detail_state.dart';
import '../screens/credential_detail_screen.dart';

class CredentialDetailContainer
    extends BlocConsumer<CredentialDetailBloc, CredentialDetailState> {
  CredentialDetailContainer({
    super.key,
    required this.onRevoked,
  }) : super(
         listener: (context, state) {
           final l10n = AppLocalizations.of(context);
           if (state.error != null) {
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                 content:
                     Text(l10n.credentialDetailError),
               ),
             );
           }
           if (state.isRevoked) {
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                 content:
                     Text(l10n.credentialRevokedSuccess),
               ),
             );
             onRevoked(state.credential);
           }
         },
         builder: (context, state) {
           return CredentialDetailScreen(
             credential: state.credential,
             isRevoking: state.isRevoking,
             isAddingToWallet: state.isAddingToWallet,
             onAddToWallet:
                 state.credential.status != 'revoked'
                 ? () {
                     CredentialDetailBlocProvider.of(
                       context,
                     ).add(const AddCredentialToWallet());
                   }
                 : null,
             onRevoke:
                 state.credential.status != 'revoked'
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
