import 'package:dependencies/dependencies.dart';

import '../../domain/errors/signup_errors.dart';

final class SignupBlocState extends Equatable {
  const SignupBlocState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
  });

  final bool isLoading;
  final bool isAuthenticated;
  final SignupErrors? error;

  SignupBlocState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    SignupErrors? Function()? error,
  }) {
    return SignupBlocState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isAuthenticated, error];
}
