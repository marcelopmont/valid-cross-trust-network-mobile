import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

import '../../../credentials_list/domain/entities/verifiable_credential_entity.dart';
import '../../domain/entities/verifier_request_entity.dart';
import '../../domain/errors/credential_sharing_errors.dart';
import 'credential_sharing_bloc.dart';
import 'credential_sharing_state.dart';

part 'events/initialize_sharing.dart';
part 'events/select_credential.dart';
part 'events/submit_presentation.dart';
part 'events/clear_sharing_error.dart';

@immutable
sealed class CredentialSharingEvent extends Equatable {
  const CredentialSharingEvent();

  Future<void> execute(
    CredentialSharingBloc bloc,
    Emitter<CredentialSharingState> emit,
  );

  @override
  List get props => [DateTime.now().toIso8601String()];
}
