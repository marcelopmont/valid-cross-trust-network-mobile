import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

import '../../domain/errors/credentials_errors.dart';
import 'credentials_list_bloc.dart';
import 'credentials_list_state.dart';

part 'events/load_credentials.dart';
part 'events/clear_credentials_error.dart';
part 'events/add_to_wallet.dart';

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
