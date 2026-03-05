import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

import '../../domain/errors/signup_errors.dart';
import 'signup_bloc.dart';
import 'signup_bloc_state.dart';

part 'events/perform_signup.dart';

@immutable
sealed class SignupBlocEvent extends Equatable {
  const SignupBlocEvent();

  Future<void> execute(SignupBloc bloc, Emitter<SignupBlocState> emit);

  @override
  List get props => [DateTime.now().toIso8601String()];
}
