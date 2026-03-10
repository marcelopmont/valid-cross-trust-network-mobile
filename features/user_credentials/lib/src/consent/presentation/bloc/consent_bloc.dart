import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/consent_repository.dart';
import 'consent_bloc_event.dart';
import 'consent_bloc_state.dart';

class ConsentBloc extends Bloc<ConsentBlocEvent, ConsentBlocState> {
  ConsentBloc({required this.schemaId, required this.consentRepository})
    : super(const ConsentBlocState()) {
    on<ConsentBlocEvent>((event, emit) => event.execute(this, emit));
  }

  final String schemaId;
  final ConsentRepository consentRepository;
}

class ConsentBlocProvider extends BlocProvider<ConsentBloc> {
  ConsentBlocProvider({super.key, required String schemaId, super.child})
    : super(
        create: (context) => ConsentBloc(
          schemaId: schemaId,
          consentRepository: di<ConsentRepository>(),
        )..add(const CheckConsent()),
      );

  static ConsentBloc of(BuildContext context) =>
      BlocProvider.of<ConsentBloc>(context);
}
