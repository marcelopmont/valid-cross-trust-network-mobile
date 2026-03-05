import 'package:dependencies/dependencies.dart';

import '../../domain/errors/signup_errors.dart';

final class SignupBlocState extends Equatable {
  const SignupBlocState({
    this.isLoading = false,
    this.isRegistered = false,
    this.error,
  });

  final bool isLoading;
  final bool isRegistered;
  final SignupErrors? error;

  SignupBlocState copyWith({
    bool? isLoading,
    bool? isRegistered,
    SignupErrors? Function()? error,
  }) {
    return SignupBlocState(
      isLoading: isLoading ?? this.isLoading,
      isRegistered: isRegistered ?? this.isRegistered,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isRegistered, error];
}
