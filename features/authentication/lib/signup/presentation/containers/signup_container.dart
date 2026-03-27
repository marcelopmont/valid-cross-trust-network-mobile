import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/errors/signup_errors.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_bloc_event.dart';
import '../bloc/signup_bloc_state.dart';
import '../screens/signup_screen.dart';

class SignupContainer extends BlocConsumer<SignupBloc, SignupBlocState> {
  SignupContainer({
    super.key,
    required VoidCallback onSignupSuccess,
    required VoidCallback onNavigateToSignin,
  }) : super(
         listener: (context, state) {
           if (state.isAuthenticated) {
             onSignupSuccess();
           }

           if (state.error != null) {
             final l10n = AppLocalizations.of(context);
             final message = switch (state.error!) {
               SignupErrors.userAlreadyExists =>
                 l10n.userAlreadyRegistered,
               SignupErrors.networkError =>
                 l10n.connectionError,
               SignupErrors.timeOut => l10n.timeoutError,
               SignupErrors.unknownError =>
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
           return SignupScreen(
             isLoading: state.isLoading,
             onSignup: (cpf, password) =>
                 SignupBlocProvider.of(context).add(
               PerformSignup(cpf: cpf, password: password),
             ),
             onNavigateToSignin: onNavigateToSignin,
           );
         },
       );
}
