import 'package:dependencies/dependencies.dart';

import '../../../credentials_list/domain/entities/verifiable_credential_entity.dart';
import '../../../credentials_list/domain/errors/credentials_errors.dart';

final class CredentialDetailState extends Equatable {
  const CredentialDetailState({
    required this.credential,
    this.isRevoking = false,
    this.isRevoked = false,
    this.error,
  });

  final VerifiableCredentialEntity credential;
  final bool isRevoking;
  final bool isRevoked;
  final CredentialsErrors? error;

  @override
  List<Object?> get props => [credential, isRevoking, isRevoked, error];

  CredentialDetailState copyWith({
    VerifiableCredentialEntity? credential,
    bool? isRevoking,
    bool? isRevoked,
    CredentialsErrors? Function()? error,
  }) {
    return CredentialDetailState(
      credential: credential ?? this.credential,
      isRevoking: isRevoking ?? this.isRevoking,
      isRevoked: isRevoked ?? this.isRevoked,
      error: error != null ? error() : this.error,
    );
  }
}
