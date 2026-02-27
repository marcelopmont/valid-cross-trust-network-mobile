import 'package:dependencies/dependencies.dart';

final class OptionsBlocState extends Equatable {
  const OptionsBlocState({
    this.isLoading = true,
    this.userDocument,
    this.isLoggedOut = false,
  });

  final bool isLoading;
  final String? userDocument;
  final bool isLoggedOut;

  OptionsBlocState copyWith({
    bool? isLoading,
    String? Function()? userDocument,
    bool? isLoggedOut,
  }) {
    return OptionsBlocState(
      isLoading: isLoading ?? this.isLoading,
      userDocument: userDocument != null ? userDocument() : this.userDocument,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
    );
  }

  @override
  List<Object?> get props => [isLoading, userDocument, isLoggedOut];
}
