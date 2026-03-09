import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/offer_entity.dart';
import 'components/download_confirmation_dialog.dart';
import 'components/header_text.dart';
import 'components/offer_card.dart';

class AvailableOffersScreen extends StatelessWidget {
  const AvailableOffersScreen({
    super.key,
    required this.isLoading,
    required this.offers,
    required this.onOfferSelected,
  });

  final bool isLoading;
  final List<OfferEntity> offers;
  final Function(OfferEntity offer) onOfferSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Credenciais Disponíveis'),
        backgroundColor: AppColors.darkBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
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
              onTap: () => DownloadConfirmationDialog.show(
                context,
                () => onOfferSelected(offer),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
