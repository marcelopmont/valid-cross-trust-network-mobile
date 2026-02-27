import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/options_repository.dart';
import 'options_bloc_event.dart';
import 'options_bloc_state.dart';

class OptionsBloc extends Bloc<OptionsBlocEvent, OptionsBlocState> {
  OptionsBloc({required this.optionsRepository})
    : super(const OptionsBlocState()) {
    on<OptionsBlocEvent>((event, emit) => event.execute(this, emit));
  }

  final OptionsRepository optionsRepository;
}

class OptionsBlocProvider extends BlocProvider<OptionsBloc> {
  OptionsBlocProvider({super.key, super.child})
    : super(
        create: (context) =>
            OptionsBloc(optionsRepository: di<OptionsRepository>())
              ..add(const LoadUserDocument()),
      );

  static OptionsBloc of(BuildContext context) =>
      BlocProvider.of<OptionsBloc>(context);
}
