import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/errors/consent_errors.dart';
import '../bloc/consent_bloc.dart';
import '../bloc/consent_bloc_event.dart';
import '../bloc/consent_bloc_state.dart';
import '../screens/consent_screen.dart';

class ConsentContainer extends BlocConsumer<ConsentBloc, ConsentBlocState> {
  ConsentContainer({
    super.key,
    required VoidCallback onConsentGranted,
    required VoidCallback onLogout,
  }) : super(
         listener: (context, state) {
           if (state.hasActiveConsent || state.isConsentGranted) {
             onConsentGranted();
           }

           if (state.isLoggedOut) {
             onLogout();
           }

           if (state.error != null) {
             final message = switch (state.error!) {
               ConsentErrors.networkError => 'Erro de conexão. Tente novamente',
               ConsentErrors.timeOut => 'Tempo esgotado. Tente novamente',
               ConsentErrors.unknownError => 'Erro inesperado. Tente novamente',
             };
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(message), backgroundColor: Colors.red),
             );
           }
         },
         builder: (context, state) {
           if (state.isCheckingConsent) {
             return const Scaffold(
               body: Center(child: CircularProgressIndicator()),
             );
           }

           return ConsentScreen(
             isGranting: state.isGranting,
             showDeclinedMessage: state.showDeclinedMessage,
             onAccept: () =>
                 ConsentBlocProvider.of(context).add(const GrantConsent()),
             onLogout: () =>
                 ConsentBlocProvider.of(context).add(const PerformLogout()),
           );
         },
       );
}
