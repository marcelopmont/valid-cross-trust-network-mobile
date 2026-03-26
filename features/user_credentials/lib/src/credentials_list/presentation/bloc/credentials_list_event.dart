import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entities/verifiable_credential_entity.dart';
import '../../domain/errors/credentials_errors.dart';
import 'credentials_list_bloc.dart';
import 'credentials_list_state.dart';

part 'events/load_credentials.dart';
part 'events/clear_credentials_error.dart';
part 'events/prepend_credential.dart';
part 'events/update_credential.dart';

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
