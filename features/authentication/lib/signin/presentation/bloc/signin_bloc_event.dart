import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

import '../../domain/errors/signin_errors.dart';
import 'signin_bloc.dart';
import 'signin_bloc_state.dart';

part 'events/perform_signin.dart';

@immutable
sealed class SigninBlocEvent extends Equatable {
  const SigninBlocEvent();

  Future<void> execute(SigninBloc bloc, Emitter<SigninBlocState> emit);

  @override
  List get props => [DateTime.now().toIso8601String()];
}
