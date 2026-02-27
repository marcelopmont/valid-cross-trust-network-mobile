import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

import 'options_bloc.dart';
import 'options_bloc_state.dart';

part 'events/load_user_document.dart';
part 'events/perform_logout.dart';

@immutable
sealed class OptionsBlocEvent extends Equatable {
  const OptionsBlocEvent();

  Future<void> execute(OptionsBloc bloc, Emitter<OptionsBlocState> emit);

  @override
  List get props => [DateTime.now().toIso8601String()];
}
