import 'package:authentication/authentication.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/consent_repository.dart';
import 'consent_bloc_event.dart';
import 'consent_bloc_state.dart';

class ConsentBloc extends Bloc<ConsentBlocEvent, ConsentBlocState> {
  ConsentBloc({
    required this.consentRepository,
    required this.tokenStorageService,
    required this.userDocumentStorageService,
  }) : super(const ConsentBlocState()) {
    on<ConsentBlocEvent>((event, emit) => event.execute(this, emit));
  }

  final ConsentRepository consentRepository;
  final TokenStorageService tokenStorageService;
  final UserDocumentStorageService userDocumentStorageService;
}

class ConsentBlocProvider extends BlocProvider<ConsentBloc> {
  ConsentBlocProvider({super.key, super.child})
    : super(
        create: (context) => ConsentBloc(
          consentRepository: di<ConsentRepository>(),
          tokenStorageService: di<TokenStorageService>(),
          userDocumentStorageService: di<UserDocumentStorageService>(),
        )..add(const CheckConsent()),
      );

  static ConsentBloc of(BuildContext context) =>
      BlocProvider.of<ConsentBloc>(context);
}
