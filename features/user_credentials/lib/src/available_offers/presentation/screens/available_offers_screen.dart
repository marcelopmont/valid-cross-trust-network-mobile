import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/offer_entity.dart';
import 'components/download_confirmation_dialog.dart';
import 'components/header_text.dart';
import 'components/issuer_section.dart';

class AvailableOffersScreen extends StatefulWidget {
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
  State<AvailableOffersScreen> createState() => _AvailableOffersScreenState();
}

class _AvailableOffersScreenState extends State<AvailableOffersScreen> {
  final Map<String, bool> _expandedSections = {
    'gov': false,
    'detran': false,
    'cofen': true,
  };

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
      body: widget.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderText(),
          const SizedBox(height: 20),
          IssuerSection(
            iconPath: 'assets/images/gov.png',
            offers: const [],
            isExpanded: _expandedSections['gov'] ?? false,
            onToggle: () => _toggleSection('gov'),
            onOfferTap: _onOfferTap,
          ),
          const SizedBox(height: 12),
          IssuerSection(
            iconPath: 'assets/images/detran.png',
            offers: const [],
            isExpanded: _expandedSections['detran'] ?? false,
            onToggle: () => _toggleSection('detran'),
            onOfferTap: _onOfferTap,
          ),
          const SizedBox(height: 12),
          IssuerSection(
            iconPath: 'assets/images/cofen.png',
            offers: widget.offers,
            isExpanded: _expandedSections['cofen'] ?? false,
            onToggle: () => _toggleSection('cofen'),
            onOfferTap: _onOfferTap,
          ),
        ],
      ),
    );
  }

  void _toggleSection(String id) {
    setState(() {
      _expandedSections[id] = !(_expandedSections[id] ?? false);
    });
  }

  void _onOfferTap(OfferEntity offer) {
    DownloadConfirmationDialog.show(
      context,
      () => widget.onOfferSelected(offer),
    );
  }
}
