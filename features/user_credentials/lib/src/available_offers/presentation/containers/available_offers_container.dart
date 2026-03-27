import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../bloc/available_offers_bloc.dart';
import '../bloc/available_offers_event.dart';
import '../bloc/available_offers_state.dart';
import '../screens/available_offers_screen.dart';

class AvailableOffersContainer
    extends BlocConsumer<AvailableOffersBloc, AvailableOffersState> {
  AvailableOffersContainer({super.key})
    : super(
        listener: (context, state) {
          if (state.issuedCredential != null) {
            context.pop(state.issuedCredential);
          }

          if (state.error != null) {
            final l10n = AppLocalizations.of(context);
            final message = switch (state.error!) {
              'offersLoadError' => l10n.offersLoadError,
              'credentialIssueError' =>
                l10n.credentialIssueError,
              _ => l10n.unexpectedError,
            };
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return AvailableOffersScreen(
            isLoading: state.isLoading,
            offers: state.offers,
            issuingOfferId: state.issuingOfferId,
            onOfferSelected: (offer) async {
              final consentId = await context.pushNamed<String?>(
                RouteNames.consent,
                pathParameters: {'schemaId': offer.schemaId},
              );

              if (consentId != null && context.mounted) {
                AvailableOffersBlocProvider.of(context).add(
                  IssueCredential(
                    offerId: offer.id,
                    consentId: consentId,
                  ),
                );
              }
            },
          );
        },
      );
}
