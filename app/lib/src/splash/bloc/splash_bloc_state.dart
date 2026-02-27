import 'package:dependencies/dependencies.dart';

final class SplashBlocState extends Equatable {
  const SplashBlocState({this.isChecking = true, this.isLoggedIn = false});

  final bool isChecking;
  final bool isLoggedIn;

  SplashBlocState copyWith({bool? isChecking, bool? isLoggedIn}) {
    return SplashBlocState(
      isChecking: isChecking ?? this.isChecking,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  List<Object?> get props => [isChecking, isLoggedIn];
}
