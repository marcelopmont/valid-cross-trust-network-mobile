import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

import 'credentials_list_bloc.dart';
import 'credentials_list_state.dart';

@immutable
sealed class CredentialsListEvent extends Equatable {
  const CredentialsListEvent();

  Future<void> execute(
    CredentialsListBloc bloc,
    Emitter<CredentialsListState> emit,
  );

  @override
  List get props => [DateTime.now().toIso8601String()];
}
