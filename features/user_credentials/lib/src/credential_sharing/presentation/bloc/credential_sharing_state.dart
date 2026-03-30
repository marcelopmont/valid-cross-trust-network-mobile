import 'package:dependencies/dependencies.dart';

import '../../../credentials_list/domain/entities/verifiable_credential_entity.dart';
import '../../domain/entities/presentation_result_entity.dart';
import '../../domain/entities/verifier_request_entity.dart';
import '../../domain/errors/credential_sharing_errors.dart';

final class CredentialSharingState extends Equatable {
  const CredentialSharingState({
    this.verifierRequest,
    this.matchingCredentials = const [],
    this.selectedCredential,
    this.isSubmitting = false,
    this.result,
    this.error,
  });

  final VerifierRequestEntity? verifierRequest;
  final List<VerifiableCredentialEntity> matchingCredentials;
  final VerifiableCredentialEntity? selectedCredential;
  final bool isSubmitting;
  final PresentationResultEntity? result;
  final CredentialSharingErrors? error;

  @override
  List<Object?> get props => [
    verifierRequest,
    matchingCredentials,
    selectedCredential,
    isSubmitting,
    result,
    error,
  ];

  CredentialSharingState copyWith({
    VerifierRequestEntity? verifierRequest,
    List<VerifiableCredentialEntity>? matchingCredentials,
    VerifiableCredentialEntity? Function()? selectedCredential,
    bool? isSubmitting,
    PresentationResultEntity? Function()? result,
    CredentialSharingErrors? Function()? error,
  }) {
    return CredentialSharingState(
      verifierRequest: verifierRequest ?? this.verifierRequest,
      matchingCredentials: matchingCredentials ?? this.matchingCredentials,
      selectedCredential: selectedCredential != null
          ? selectedCredential()
          : this.selectedCredential,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      result: result != null ? result() : this.result,
      error: error != null ? error() : this.error,
    );
  }
}
