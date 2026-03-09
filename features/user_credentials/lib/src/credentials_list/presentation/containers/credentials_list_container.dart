import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../bloc/credentials_list_bloc.dart';
import '../bloc/credentials_list_event.dart';
import '../bloc/credentials_list_state.dart';
import '../screens/credentials_list_screen.dart';

class CredentialsListContainer
    extends BlocConsumer<CredentialsListBloc, CredentialsListState> {
  CredentialsListContainer({super.key})
    : super(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Erro ao carregar credenciais')),
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
            onAddCredential: () async {
              await context.pushNamed(RouteNames.availableOffers);
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
