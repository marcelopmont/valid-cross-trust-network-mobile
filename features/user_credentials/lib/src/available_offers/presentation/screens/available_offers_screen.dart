import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/offer_entity.dart';
import 'components/header_text.dart';
import 'components/offer_card.dart';

class AvailableOffersScreen extends StatelessWidget {
  const AvailableOffersScreen({
    super.key,
    required this.isLoading,
    required this.offers,
    required this.issuingOfferId,
    required this.onOfferSelected,
  });

  final bool isLoading;
  final List<OfferEntity> offers;
  final String? issuingOfferId;
  final Function(OfferEntity offer) onOfferSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const ValidAppBar(titleText: 'Credenciais Disponíveis'),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (offers.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.folder_open_outlined,
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 24),
              Text(
                'Nenhuma oferta disponível',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderText(),
          const SizedBox(height: 20),
          ...offers.map(
            (offer) => OfferCard(
              offer: offer,
              isIssuing: issuingOfferId == offer.id,
              onEmit: () => onOfferSelected(offer),
            ),
          ),
        ],
      ),
    );
  }
}
