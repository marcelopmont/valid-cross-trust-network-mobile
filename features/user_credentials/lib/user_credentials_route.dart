import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import 'src/available_offers/presentation/bloc/available_offers_bloc.dart';
import 'src/available_offers/presentation/containers/available_offers_container.dart';
import 'src/consent/presentation/bloc/consent_bloc.dart';
import 'src/consent/presentation/containers/consent_container.dart';
import 'src/credentials_list/presentation/bloc/credentials_list_bloc.dart';
import 'src/credentials_list/presentation/containers/credentials_list_container.dart';
import 'src/liveness/presentation/bloc/liveness_verification_bloc.dart';
import 'src/liveness/presentation/containers/liveness_verification_container.dart';

class UserCredentialsRoute extends GoRoute {
  UserCredentialsRoute()
    : super(
        name: RouteNames.credentialsList,
        path: '/credentials',
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final qrCode = extra?['qrCode'];

          return NoTransitionPage(
            child: CredentialsListBlocProvider(
              child: Builder(
                builder: (context) {
                  if (qrCode != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      CredentialsListBlocProvider.of(context);
                    });
                  }
                  return CredentialsListContainer();
                },
              ),
            ),
          );
        },
        routes: [
          GoRoute(
            name: RouteNames.availableOffers,
            path: 'available-offers',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: AvailableOffersBlocProvider(
                  child: AvailableOffersContainer(),
                ),
              );
            },
            routes: [
              GoRoute(
                name: RouteNames.consent,
                path: 'consent/:schemaId',
                pageBuilder: (context, state) {
                  final schemaId = state.pathParameters['schemaId']!;
                  return NoTransitionPage(
                    child: ConsentBlocProvider(
                      schemaId: schemaId,
                      child: ConsentContainer(
                        onGoBack: (consentId) {
                          context.pop(consentId);
                        },
                      ),
                    ),
                  );
                },
              ),
              GoRoute(
                name: RouteNames.livenessVerification,
                path: 'liveness/:credentialId',
                pageBuilder: (context, state) {
                  final credentialId = state.pathParameters['credentialId']!;
                  return NoTransitionPage(
                    child: LivenessVerificationBlocProvider(
                      credentialId: credentialId,
                      child: LivenessVerificationContainer(
                        onSuccess: () {
                          context.pop(true);
                        },
                        onCancel: () {
                          context.pop(false);
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      );
}
