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
           if (state.isRegistered) {
             ScaffoldMessenger.of(context).showSnackBar(
               const SnackBar(
                 content: Text('Cadastro realizado com sucesso!'),
                 backgroundColor: Colors.green,
               ),
             );
             onSignupSuccess();
           }

           if (state.error != null) {
             final message = switch (state.error!) {
               SignupErrors.userAlreadyExists => 'Usuário já cadastrado',
               SignupErrors.networkError => 'Erro de conexão. Tente novamente',
               SignupErrors.timeOut => 'Tempo esgotado. Tente novamente',
               SignupErrors.unknownError => 'Erro inesperado. Tente novamente',
             };
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(message), backgroundColor: Colors.red),
             );
           }
         },
         builder: (context, state) {
           return SignupScreen(
             isLoading: state.isLoading,
             onSignup: (cpf, password) => SignupBlocProvider.of(
               context,
             ).add(PerformSignup(cpf: cpf, password: password)),
             onNavigateToSignin: onNavigateToSignin,
           );
         },
       );
}
