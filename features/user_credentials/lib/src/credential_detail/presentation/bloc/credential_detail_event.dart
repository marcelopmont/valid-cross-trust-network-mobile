import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

import '../../../credentials_list/domain/entities/verifiable_credential_entity.dart';
import '../../../credentials_list/domain/errors/credentials_errors.dart';
import 'credential_detail_bloc.dart';
import 'credential_detail_state.dart';

part 'events/revoke_credential.dart';

@immutable
sealed class CredentialDetailEvent extends Equatable {
  const CredentialDetailEvent();

  Future<void> execute(
    CredentialDetailBloc bloc,
    Emitter<CredentialDetailState> emit,
  );

  @override
  List get props => [DateTime.now().toIso8601String()];
}
