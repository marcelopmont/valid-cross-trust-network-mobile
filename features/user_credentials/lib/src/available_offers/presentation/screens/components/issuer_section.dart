import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/offer_entity.dart';
import 'issuer_expanded_content.dart';

class IssuerSection extends StatelessWidget {
  const IssuerSection({
    super.key,
    required this.iconPath,
    required this.offers,
    required this.isExpanded,
    required this.onToggle,
    required this.onOfferTap,
  });

  final String iconPath;
  final List<OfferEntity> offers;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Function(OfferEntity offer) onOfferTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          // Header - just the icon
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.vertical(
              top: const Radius.circular(12),
              bottom: isExpanded ? Radius.zero : const Radius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Icon
                  Image.asset(
                    iconPath,
                    width: 70,
                    height: 40,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.business,
                          color: Colors.grey[600],
                          size: 24,
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  // Badge count
                  if (offers.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darkBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${offers.length}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  // Chevron
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Divider when expanded
          if (isExpanded) Divider(height: 1, color: Colors.grey[200]),
          // Expandable content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: IssuerExpandedContent(
              offers: offers,
              onOfferTap: onOfferTap,
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
