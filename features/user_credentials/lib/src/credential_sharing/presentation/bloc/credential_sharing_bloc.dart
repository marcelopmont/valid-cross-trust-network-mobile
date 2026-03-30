import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../../credentials_list/domain/repositories/credentials_repository.dart';
import '../../domain/entities/verifier_request_entity.dart';
import '../../domain/repositories/credential_sharing_repository.dart';
import 'credential_sharing_event.dart';
import 'credential_sharing_state.dart';

class CredentialSharingBloc
    extends Bloc<CredentialSharingEvent, CredentialSharingState> {
  CredentialSharingBloc({
    required this.credentialSharingRepository,
    required this.credentialsRepository,
    required this.verifierRequest,
  }) : super(const CredentialSharingState()) {
    on<CredentialSharingEvent>((event, emit) => event.execute(this, emit));
  }

  final CredentialSharingRepository credentialSharingRepository;
  final CredentialsRepository credentialsRepository;
  final VerifierRequestEntity verifierRequest;
}

class CredentialSharingBlocProvider
    extends BlocProvider<CredentialSharingBloc> {
  CredentialSharingBlocProvider({
    super.key,
    super.child,
    required VerifierRequestEntity verifierRequest,
  }) : super(
         create: (context) => CredentialSharingBloc(
           credentialSharingRepository: di<CredentialSharingRepository>(),
           credentialsRepository: di<CredentialsRepository>(),
           verifierRequest: verifierRequest,
         )..add(InitializeSharing(verifierRequest: verifierRequest)),
       );

  static CredentialSharingBloc of(BuildContext context) =>
      BlocProvider.of<CredentialSharingBloc>(context);
}
