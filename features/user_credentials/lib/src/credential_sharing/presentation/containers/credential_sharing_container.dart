import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../bloc/credential_sharing_bloc.dart';
import '../bloc/credential_sharing_event.dart';
import '../bloc/credential_sharing_state.dart';
import '../screens/credential_sharing_screen.dart';

class CredentialSharingContainer
    extends BlocConsumer<CredentialSharingBloc, CredentialSharingState> {
  CredentialSharingContainer({super.key})
    : super(
        listener: (context, state) {
          if (state.result != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context).sharingSuccess),
              ),
            );
            context.pop(true);
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context).sharingError),
              ),
            );
            CredentialSharingBlocProvider.of(
              context,
            ).add(const ClearSharingError());
          }
        },
        builder: (context, state) {
          return CredentialSharingScreen(
            verifierRequest: state.verifierRequest,
            matchingCredentials: state.matchingCredentials,
            selectedCredential: state.selectedCredential,
            isSubmitting: state.isSubmitting,
            onSelectCredential: (credential) {
              CredentialSharingBlocProvider.of(
                context,
              ).add(SelectCredential(credential: credential));
            },
            onConfirm: () {
              CredentialSharingBlocProvider.of(
                context,
              ).add(const SubmitPresentation());
            },
            onCancel: () => context.pop(),
          );
        },
      );
}
