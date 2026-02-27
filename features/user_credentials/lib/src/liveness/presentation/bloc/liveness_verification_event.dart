import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

import 'liveness_verification_bloc.dart';
import 'liveness_verification_state.dart';

part 'events/start_liveness_check.dart';
part 'events/set_credential_id.dart';

@immutable
sealed class LivenessVerificationEvent extends Equatable {
  const LivenessVerificationEvent();

  Future<void> execute(
    LivenessVerificationBloc bloc,
    Emitter<LivenessVerificationState> emit,
  );

  @override
  List get props => [DateTime.now().toIso8601String()];
}
