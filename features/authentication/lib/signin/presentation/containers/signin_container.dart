import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../bloc/signin_bloc.dart';
import '../bloc/signin_bloc_event.dart';
import '../bloc/signin_bloc_state.dart';
import '../screens/signin_screen.dart';

class SigninContainer extends BlocConsumer<SigninBloc, SigninBlocState> {
  SigninContainer({super.key, required VoidCallback onSigninSuccess})
    : super(
        listener: (context, state) {
          if (state.isAuthenticated) {
            onSigninSuccess();
          }

          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SigninScreen(
            onSignin: (document) =>
                SigninBlocProvider.of(context).add(PerformSignin(document)),
          );
        },
      );
}
