import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/errors/consent_errors.dart';
import '../bloc/consent_bloc.dart';
import '../bloc/consent_bloc_event.dart';
import '../bloc/consent_bloc_state.dart';
import '../screens/consent_screen.dart';

class ConsentContainer
    extends BlocConsumer<ConsentBloc, ConsentBlocState> {
  ConsentContainer({
    super.key,
    required ValueChanged<String?> onGoBack,
  }) : super(
         listener: (context, state) {
           if (state.generatedConsentId != null) {
             onGoBack(state.generatedConsentId);
           }

           if (state.error != null) {
             final l10n = AppLocalizations.of(context);
             final message = switch (state.error!) {
               ConsentErrors.networkError =>
                 l10n.connectionError,
               ConsentErrors.timeOut => l10n.timeoutError,
               ConsentErrors.unknownError =>
                 l10n.unexpectedError,
             };
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                 content: Text(message),
                 backgroundColor: Colors.red,
               ),
             );
           }
         },
         builder: (context, state) {
           if (state.isCheckingConsent) {
             return const Scaffold(
               body: Center(
                 child: CircularProgressIndicator(),
               ),
             );
           }

           return ConsentScreen(
             isGranting: state.isGranting,
             showDeclinedMessage: state.showDeclinedMessage,
             onAccept: () => ConsentBlocProvider.of(context)
                 .add(const GrantConsent()),
             onGoBack: () => onGoBack(null),
           );
         },
       );
}
