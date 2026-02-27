import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../bloc/liveness_verification_bloc.dart';
import '../bloc/liveness_verification_event.dart';
import '../bloc/liveness_verification_state.dart';
import '../screens/liveness_explanation_screen.dart';

class LivenessVerificationContainer extends StatelessWidget {
  const LivenessVerificationContainer({
    super.key,
    required this.onSuccess,
    required this.onCancel,
  });

  final VoidCallback onSuccess;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LivenessVerificationBloc, LivenessVerificationState>(
      listener: (context, state) {
        if (state.isFailure && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state.livenessCompleted && state.isSuccess) {
          onSuccess();
        }
      },
      builder: (context, state) {
        return LivenessExplanationScreen(
          isLoading: state.isLoading,
          onAgree: () {
            LivenessVerificationBlocProvider.of(
              context,
            ).add(const StartLivenessCheck());
          },
          onCancel: onCancel,
        );
      },
    );
  }
}
