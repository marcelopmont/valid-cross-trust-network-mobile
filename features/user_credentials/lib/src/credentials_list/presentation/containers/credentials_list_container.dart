import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/verifiable_credential_entity.dart';
import '../bloc/credentials_list_bloc.dart';
import '../bloc/credentials_list_event.dart';
import '../bloc/credentials_list_state.dart';
import '../screens/credentials_list_screen.dart';

class CredentialsListContainer
    extends BlocConsumer<CredentialsListBloc, CredentialsListState> {
  CredentialsListContainer({super.key})
    : super(
        listener: (context, state) {
          if (state.isLoggedOut) {
            context.goNamed(RouteNames.signin);
          }
          if (state.error != null) {
            final l10n = AppLocalizations.of(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.credentialsLoadError),
              ),
            );
            CredentialsListBlocProvider.of(
              context,
            ).add(const ClearCredentialsError());
          }
        },
        builder: (context, state) {
          return CredentialsListScreen(
            isLoading: state.isLoading,
            credentials: state.credentials,
            hasReachedEnd: state.hasReachedEnd,
            issuingWalletCredentialId:
                state.issuingWalletCredentialId,
            userDocument: state.userDocument,
            onLogout: () => CredentialsListBlocProvider.of(
              context,
            ).add(const PerformLogout()),
            onAddCredential: () async {
              final result = await context.pushNamed(
                RouteNames.availableOffers,
              );
              if (result is VerifiableCredentialEntity &&
                  context.mounted) {
                CredentialsListBlocProvider.of(
                  context,
                ).add(
                  PrependCredential(credential: result),
                );
              }
            },
            onCredentialTap: (credential) async {
              final result = await context.pushNamed(
                RouteNames.credentialDetail,
                extra: credential,
              );
              if (result is VerifiableCredentialEntity &&
                  context.mounted) {
                CredentialsListBlocProvider.of(
                  context,
                ).add(
                  UpdateCredential(credential: result),
                );
              }
            },
            onLoadMore: () {
              CredentialsListBlocProvider.of(
                context,
              ).add(const LoadCredentials());
            },
          );
        },
      );
}
