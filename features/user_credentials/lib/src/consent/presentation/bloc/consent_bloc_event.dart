import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

import '../../domain/errors/consent_errors.dart';
import 'consent_bloc.dart';
import 'consent_bloc_state.dart';

part 'events/check_consent.dart';
part 'events/grant_consent.dart';

@immutable
sealed class ConsentBlocEvent extends Equatable {
  const ConsentBlocEvent();

  Future<void> execute(ConsentBloc bloc, Emitter<ConsentBlocState> emit);

  @override
  List get props => [DateTime.now().toIso8601String()];
}
