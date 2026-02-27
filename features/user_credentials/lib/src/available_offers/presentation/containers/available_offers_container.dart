import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../bloc/available_offers_bloc.dart';
import '../bloc/available_offers_state.dart';
import '../screens/available_offers_screen.dart';

class AvailableOffersContainer
    extends BlocConsumer<AvailableOffersBloc, AvailableOffersState> {
  AvailableOffersContainer({super.key})
    : super(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state.isCredentialIssued) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Credencial adicionada à carteira!'),
                backgroundColor: Colors.green,
              ),
            );
            context.pop();
          }
        },
        builder: (context, state) {
          return AvailableOffersScreen(
            isLoading: state.isLoading,
            offers: state.offers,
            onOfferSelected: (offer) async {
              final success =
                  await context.pushNamed<bool>(
                    RouteNames.livenessVerification,
                    pathParameters: {'credentialId': offer.credentialId},
                  ) ??
                  false;
              if (success) {}
            },
          );
        },
      );
}
