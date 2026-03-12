import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/credentials_repository.dart';
import 'credentials_list_event.dart';
import 'credentials_list_state.dart';

class CredentialsListBloc
    extends Bloc<CredentialsListEvent, CredentialsListState> {
  CredentialsListBloc({
    required this.credentialsRepository,
    required this.googleWalletService,
  }) : super(const CredentialsListState()) {
    on<CredentialsListEvent>((event, emit) => event.execute(this, emit));
  }

  final CredentialsRepository credentialsRepository;
  final GoogleWalletService googleWalletService;
}

class CredentialsListBlocProvider extends BlocProvider<CredentialsListBloc> {
  CredentialsListBlocProvider({super.key, super.child})
    : super(
        create: (context) => CredentialsListBloc(
          credentialsRepository: di<CredentialsRepository>(),
          googleWalletService: di<GoogleWalletService>(),
        )..add(const LoadCredentials()),
      );

  static CredentialsListBloc of(BuildContext context) =>
      BlocProvider.of<CredentialsListBloc>(context);
}
