import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../bloc/options_bloc.dart';
import '../bloc/options_bloc_event.dart';
import '../bloc/options_bloc_state.dart';
import '../screens/options_screen.dart';

class OptionsContainer extends BlocConsumer<OptionsBloc, OptionsBlocState> {
  OptionsContainer({super.key})
    : super(
        listener: (context, state) {
          if (state.isLoggedOut) {
            context.goNamed(RouteNames.signin);
          }
        },
        builder: (context, state) {
          return OptionsScreen(
            isLoading: state.isLoading,
            userDocument: state.userDocument,
            onLogout: () =>
                OptionsBlocProvider.of(context).add(const PerformLogout()),
          );
        },
      );
}
