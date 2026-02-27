import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/signin_repository.dart';
import 'signin_bloc_event.dart';
import 'signin_bloc_state.dart';

class SigninBloc extends Bloc<SigninBlocEvent, SigninBlocState> {
  SigninBloc({required this.signinRepository})
    : super(const SigninBlocState()) {
    on<SigninBlocEvent>((event, emit) => event.execute(this, emit));
  }

  final SigninRepository signinRepository;
}

class SigninBlocProvider extends BlocProvider<SigninBloc> {
  SigninBlocProvider({super.key, super.child})
    : super(create: (context) => SigninBloc(signinRepository: di()));

  static SigninBloc of(BuildContext context) =>
      BlocProvider.of<SigninBloc>(context);
}
