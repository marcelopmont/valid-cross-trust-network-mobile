import 'package:dependencies/dependencies.dart';

enum LivenessStatus { initial, loading, success, failure }

final class LivenessVerificationState extends Equatable {
  const LivenessVerificationState({
    this.status = LivenessStatus.initial,
    this.credentialId,
    this.errorMessage,
    this.livenessCompleted = false,
  });

  final LivenessStatus status;
  final String? credentialId;
  final String? errorMessage;
  final bool livenessCompleted;

  bool get isLoading => status == LivenessStatus.loading;
  bool get isSuccess => status == LivenessStatus.success;
  bool get isFailure => status == LivenessStatus.failure;

  LivenessVerificationState copyWith({
    LivenessStatus? status,
    String? credentialId,
    String? Function()? errorMessage,
    bool? livenessCompleted,
  }) {
    return LivenessVerificationState(
      status: status ?? this.status,
      credentialId: credentialId ?? this.credentialId,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      livenessCompleted: livenessCompleted ?? this.livenessCompleted,
    );
  }

  @override
  List<Object?> get props => [
    status,
    credentialId,
    errorMessage,
    livenessCompleted,
  ];
}
