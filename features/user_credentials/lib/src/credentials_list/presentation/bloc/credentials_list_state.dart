import 'package:dependencies/dependencies.dart';

import '../../domain/entities/verifiable_credential_entity.dart';
import '../../domain/errors/credentials_errors.dart';

final class CredentialsListState extends Equatable {
  const CredentialsListState({
    this.credentials = const [],
    this.isLoading = false,
    this.error,
    this.total = 0,
    this.offset = 0,
    this.hasReachedEnd = false,
    this.issuingWalletCredentialId,
    this.userDocument,
    this.isLoggedOut = false,
  });

  final List<VerifiableCredentialEntity> credentials;
  final bool isLoading;
  final CredentialsErrors? error;
  final int total;
  final int offset;
  final bool hasReachedEnd;
  final String? issuingWalletCredentialId;
  final String? userDocument;
  final bool isLoggedOut;

  @override
  List<Object?> get props => [
    credentials,
    isLoading,
    error,
    total,
    offset,
    hasReachedEnd,
    issuingWalletCredentialId,
    userDocument,
    isLoggedOut,
  ];

  CredentialsListState copyWith({
    List<VerifiableCredentialEntity>? credentials,
    bool? isLoading,
    CredentialsErrors? Function()? error,
    int? total,
    int? offset,
    bool? hasReachedEnd,
    String? Function()? issuingWalletCredentialId,
    String? Function()? userDocument,
    bool? isLoggedOut,
  }) {
    return CredentialsListState(
      credentials: credentials ?? this.credentials,
      isLoading: isLoading ?? this.isLoading,
      error: error != null ? error() : this.error,
      total: total ?? this.total,
      offset: offset ?? this.offset,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      issuingWalletCredentialId: issuingWalletCredentialId != null
          ? issuingWalletCredentialId()
          : this.issuingWalletCredentialId,
      userDocument:
          userDocument != null ? userDocument() : this.userDocument,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
    );
  }
}
