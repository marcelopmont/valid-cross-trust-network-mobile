import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/signup_repository.dart';
import 'signup_bloc_event.dart';
import 'signup_bloc_state.dart';

class SignupBloc extends Bloc<SignupBlocEvent, SignupBlocState> {
  SignupBloc({required this.signupRepository})
    : super(const SignupBlocState()) {
    on<SignupBlocEvent>((event, emit) => event.execute(this, emit));
  }

  final SignupRepository signupRepository;
}

class SignupBlocProvider extends BlocProvider<SignupBloc> {
  SignupBlocProvider({super.key, super.child})
    : super(create: (context) => SignupBloc(signupRepository: di()));

  static SignupBloc of(BuildContext context) =>
      BlocProvider.of<SignupBloc>(context);
}
