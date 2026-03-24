import 'package:flutter/material.dart';

import '../../../domain/entities/verifiable_credential_entity.dart';
import 'credential_card.dart';

class CredentialsList extends StatefulWidget {
  const CredentialsList({
    super.key,
    required this.credentials,
    required this.isLoading,
    required this.hasReachedEnd,
    required this.onLoadMore,
    this.issuingWalletCredentialId,
    this.onAddWallet,
  });

  final List<VerifiableCredentialEntity> credentials;
  final bool isLoading;
  final bool hasReachedEnd;
  final VoidCallback onLoadMore;
  final String? issuingWalletCredentialId;
  final void Function(String)? onAddWallet;

  @override
  State<CredentialsList> createState() => _CredentialsListState();
}

class _CredentialsListState extends State<CredentialsList>
    with SingleTickerProviderStateMixin {
  double _scrollProgress = 0.0;
  late AnimationController _springController;
  late Animation<double> _springAnimation;

  @override
  void initState() {
    super.initState();
    _springController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _springController.addListener(() {
      setState(() {
        _scrollProgress = _springAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _springController.dispose();
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_springController.isAnimating) {
      _springController.stop();
    }
    setState(() {
      // Swiping DOWN increases scroll progress, bringing next card into view
      _scrollProgress += details.primaryDelta! / 300.0;
      _scrollProgress = _scrollProgress.clamp(
        -0.2,
        (widget.credentials.length - 1) + 0.2,
      );
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    final velocity = (details.primaryVelocity ?? 0.0) / 300.0;

    var target = (_scrollProgress + velocity * 0.2).roundToDouble();
    target = target.clamp(0.0, (widget.credentials.length - 1).toDouble());

    _springAnimation = Tween<double>(begin: _scrollProgress, end: target)
        .animate(
          CurvedAnimation(
            parent: _springController,
            curve: Curves.easeOutCubic,
          ),
        );
    _springController.forward(from: 0.0);

    if (target == widget.credentials.length - 1 &&
        !widget.isLoading &&
        !widget.hasReachedEnd) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.credentials.isEmpty && !widget.isLoading) {
      return const SizedBox();
    }

    final padding = MediaQuery.paddingOf(context);
    final topInset = padding.top + 70.0; // Estimate for AppBar clear space
    final bottomInset =
        padding.bottom + 90.0; // Estimate for BottomNavBar clear space

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        final safeHeight = height - topInset - bottomInset;
        const roughCardHeight = 260.0;

        // Ensure Active Card is exactly centered in the visible space
        final activeFocusY =
            topInset + (safeHeight / 2) - (roughCardHeight / 2);

        final topStackBase = activeFocusY - 40.0;
        // Bottom stack overlaps the very base of the active card
        final bottomStackBase = activeFocusY + roughCardHeight - 65.0;

        final topBaseRelative = topStackBase - activeFocusY;
        final bottomBaseRelative = bottomStackBase - activeFocusY;

        final renderItems = <_CardItem>[];

        for (var i = 0; i < widget.credentials.length; i++) {
          final t = i - _scrollProgress;

          final zIndex = -i.toDouble();

          var customY = 0.0;
          var scale = 1.0;
          var rotateX = 0.0;
          var opacity = 1.0;

          if (t > 0) {
            // TOP STACK
            final progress = t.clamp(0.0, 1.0);
            if (t <= 1.0) {
              customY = progress * topBaseRelative;
              scale = 1.0 - (progress * 0.1);
              rotateX =
                  -progress *
                  0.15; // Inverted rotation: pivot pulls off the deck
            } else {
              customY = topBaseRelative - ((t - 1.0) * 12.0); // Cascade up
              scale = 0.9 - ((t - 1.0) * 0.02);
              rotateX = -0.15;
            }
            opacity = 1.0;
          } else {
            // BOTTOM STACK CONVERGENCE
            final progress = t.abs().clamp(0.0, 1.0);
            if (t >= -1.0) {
              customY = progress * bottomBaseRelative;
              // Grows up to 12% larger to pop out towards the user
              scale = 1.0 + (progress * 0.12);
              rotateX = progress * 0.45;
            } else {
              final bottomDepth = t.abs() - 1.0;
              // Cascade sharply downwards
              customY = bottomBaseRelative + (bottomDepth * 25.0);
              // Older cards are slightly larger (closer)
              scale = 1.12 + (bottomDepth * 0.03);
              // Older cards are slightly more tilted
              rotateX = 0.45 + (bottomDepth * 0.05);
            }
          }

          final matrix = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Softer 3D perspective
            ..translate(0.0, activeFocusY + customY, 0.0)
            ..scale(scale)
            ..rotateX(rotateX);

          final credential = widget.credentials[i];
          final isWalletEligible =
              credential.credentialType == 'AgeVerificationCredential';

          final child = Transform(
            alignment: Alignment.center,
            transform: matrix,
            child: Opacity(
              opacity: opacity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 8.0,
                ),
                child: CredentialCard(
                  credential: credential,
                  isAddingToWallet:
                      widget.issuingWalletCredentialId ==
                      credential.credentialId,
                  onAddWallet: isWalletEligible && widget.onAddWallet != null
                      ? () => widget.onAddWallet!(credential.credentialId)
                      : null,
                ),
              ),
            ),
          );

          renderItems.add(_CardItem(child, zIndex));
        }

        renderItems.sort((a, b) => a.zIndex.compareTo(b.zIndex));

        return GestureDetector(
          onVerticalDragUpdate: _onVerticalDragUpdate,
          onVerticalDragEnd: _onVerticalDragEnd,
          child: Container(
            color: Colors.transparent,
            width: width,
            height: height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ...renderItems.map(
                  (e) => Positioned(
                    top: 0, // Pos is controlled via Transform
                    left: 0,
                    right: 0,
                    child: e.child,
                  ),
                ),
                if (widget.isLoading &&
                    _scrollProgress.round() == widget.credentials.length - 1)
                  Positioned(
                    bottom: bottomInset - 40,
                    left: width / 2 - 20,
                    child: const CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CardItem {
  final Widget child;
  final double zIndex;
  _CardItem(this.child, this.zIndex);
}
