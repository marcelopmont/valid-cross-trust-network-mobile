import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../bloc/credentials_list_bloc.dart';
import '../bloc/credentials_list_state.dart';
import '../screens/credentials_list_screen.dart';

class CredentialsListContainer
    extends BlocConsumer<CredentialsListBloc, CredentialsListState> {
  CredentialsListContainer({super.key})
    : super(
        listener: (context, state) {},
        builder: (context, state) {
          return CredentialsListScreen(
            isLoading: false,
            credentials: const [],
            onAddCredential: () async {
              await context.pushNamed(RouteNames.availableOffers);
            },
          );
        },
      );
}
