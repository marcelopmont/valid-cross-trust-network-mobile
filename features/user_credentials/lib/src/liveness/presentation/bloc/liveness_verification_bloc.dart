import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../data/services/liveness_hub_service.dart';
import 'liveness_verification_event.dart';
import 'liveness_verification_state.dart';

class LivenessVerificationBloc
    extends Bloc<LivenessVerificationEvent, LivenessVerificationState> {
  LivenessVerificationBloc({required this.livenessHubService})
    : super(const LivenessVerificationState()) {
    on<LivenessVerificationEvent>((event, emit) => event.execute(this, emit));
  }

  final LivenessHubService livenessHubService;
}

class LivenessVerificationBlocProvider
    extends BlocProvider<LivenessVerificationBloc> {
  LivenessVerificationBlocProvider({
    super.key,
    super.child,
    required String credentialId,
  }) : super(
         create: (context) => LivenessVerificationBloc(
           livenessHubService: di<LivenessHubService>(),
         )..add(SetCredentialId(credentialId: credentialId)),
       );

  static LivenessVerificationBloc of(BuildContext context) =>
      BlocProvider.of<LivenessVerificationBloc>(context);
}
