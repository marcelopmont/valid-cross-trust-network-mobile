import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/errors/signin_errors.dart';
import '../bloc/signin_bloc.dart';
import '../bloc/signin_bloc_event.dart';
import '../bloc/signin_bloc_state.dart';
import '../screens/signin_screen.dart';

class SigninContainer extends BlocConsumer<SigninBloc, SigninBlocState> {
  SigninContainer({
    super.key,
    required VoidCallback onSigninSuccess,
    required VoidCallback onNavigateToSignup,
  }) : super(
         listener: (context, state) {
           if (state.isAuthenticated) {
             onSigninSuccess();
           }

           if (state.error != null) {
             final message = switch (state.error!) {
               SigninErrors.invalidCredentials => 'CPF ou senha inválidos',
               SigninErrors.networkError => 'Erro de conexão. Tente novamente',
               SigninErrors.timeOut => 'Tempo esgotado. Tente novamente',
               SigninErrors.unknownError => 'Erro inesperado. Tente novamente',
             };
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(message), backgroundColor: Colors.red),
             );
           }
         },
         builder: (context, state) {
           return SigninScreen(
             isLoading: state.isLoading,
             onSignin: (cpf, password) => SigninBlocProvider.of(
               context,
             ).add(PerformSignin(cpf: cpf, password: password)),
             onNavigateToSignup: onNavigateToSignup,
           );
         },
       );
}
