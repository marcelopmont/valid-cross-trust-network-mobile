import 'package:dependencies/dependencies.dart';

import '../../domain/errors/signin_errors.dart';

final class SigninBlocState extends Equatable {
  const SigninBlocState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
  });

  final bool isLoading;
  final bool isAuthenticated;
  final SigninErrors? error;

  SigninBlocState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    SigninErrors? Function()? error,
  }) {
    return SigninBlocState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isAuthenticated, error];
}
