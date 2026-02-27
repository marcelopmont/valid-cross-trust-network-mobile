import 'package:dependencies/dependencies.dart';

final class SigninBlocState extends Equatable {
  const SigninBlocState({this.isAuthenticated = false, this.error});

  final bool isAuthenticated;
  final String? error;

  SigninBlocState copyWith({bool? isAuthenticated, String? Function()? error}) {
    return SigninBlocState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, error];
}
