import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../../credentials_list/domain/entities/verifiable_credential_entity.dart';
import '../../domain/repositories/credential_detail_repository.dart';
import 'credential_detail_event.dart';
import 'credential_detail_state.dart';

class CredentialDetailBloc
    extends Bloc<CredentialDetailEvent, CredentialDetailState> {
  CredentialDetailBloc({
    required this.credentialDetailRepository,
    required VerifiableCredentialEntity credential,
  }) : super(CredentialDetailState(credential: credential)) {
    on<CredentialDetailEvent>((event, emit) => event.execute(this, emit));
  }

  final CredentialDetailRepository credentialDetailRepository;
}

class CredentialDetailBlocProvider
    extends BlocProvider<CredentialDetailBloc> {
  CredentialDetailBlocProvider({
    super.key,
    super.child,
    required VerifiableCredentialEntity credential,
  }) : super(
          create: (context) => CredentialDetailBloc(
            credentialDetailRepository: di<CredentialDetailRepository>(),
            credential: credential,
          ),
        );

  static CredentialDetailBloc of(BuildContext context) =>
      BlocProvider.of<CredentialDetailBloc>(context);
}
