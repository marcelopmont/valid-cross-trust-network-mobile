import 'package:flutter/material.dart';

import '../../../domain/entities/offer_entity.dart';
import 'offer_card.dart';

class IssuerExpandedContent extends StatelessWidget {
  const IssuerExpandedContent({
    super.key,
    required this.offers,
    required this.onOfferTap,
  });

  final List<OfferEntity> offers;
  final Function(OfferEntity offer) onOfferTap;

  @override
  Widget build(BuildContext context) {
    if (offers.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open_outlined, size: 20, color: Colors.grey[400]),
            const SizedBox(width: 8),
            Text(
              'Nenhum documento disponível',
              style: TextStyle(fontSize: 13, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: offers
            .map(
              (offer) =>
                  OfferCard(offer: offer, onTap: () => onOfferTap(offer)),
            )
            .toList(),
      ),
    );
  }
}
