import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/verifiable_credential_entity.dart';

class CredentialsListScreen extends StatelessWidget {
  const CredentialsListScreen({
    super.key,
    required this.isLoading,
    required this.credentials,
    required this.onAddCredential,
  });

  final bool isLoading;
  final List<VerifiableCredentialEntity> credentials;
  final VoidCallback onAddCredential;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carteira'),
        backgroundColor: AppColors.darkBlue,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : credentials.isEmpty
          ? _buildEmptyState(context)
          : _buildCredentialsList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddCredential,
        backgroundColor: AppColors.darkBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.credit_card_outlined, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            Text(
              'Nenhuma credencial',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Toque no botão + para adicionar uma nova credencial',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCredentialsList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: credentials.length,
      itemBuilder: (context, index) {
        final credential = credentials[index];
        const isValid = true;
        return _SwipeableCredentialCard(
          credential: credential,
          isValid: isValid,
          onRevoke: () {},
          cardBuilder: (cred, {isValid}) {
            return _buildCredentialCard(context, cred, isValid);
          },
        );
      },
    );
  }

  Widget _buildCredentialCard(
    BuildContext context,
    VerifiableCredentialEntity credential,
    bool? isValid,
  ) {
    final subject = credential.credentialSubject;
    final type = subject['licenseType'] ?? '';
    final name = subject['holderName'] ?? '';
    final documentNumber = subject['registrationNumber'] ?? '';
    final specialty = subject['specialty'] ?? '';

    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.darkBlue, AppColors.lightBlue],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    type,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                _buildValidationBadge(isValid),
              ],
            ),
            const SizedBox(height: 16),
            if (name.toString().isNotEmpty) ...[
              Text(
                name.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
            ],
            if (documentNumber.toString().isNotEmpty)
              Text(
                documentNumber.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              specialty,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationBadge(bool? isValid) {
    if (isValid == null) {
      // Verification in progress
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 4),
            Text(
              'Verificando...',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      );
    }

    if (isValid) {
      // Valid credential
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              'Verificada',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      );
    }

    // Invalid/revoked credential
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cancel, color: Colors.white, size: 16),
          SizedBox(width: 4),
          Text('Revogada', style: TextStyle(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }
}

class _SwipeableCredentialCard extends StatefulWidget {
  const _SwipeableCredentialCard({
    required this.credential,
    required this.isValid,
    required this.onRevoke,
    required this.cardBuilder,
  });

  final VerifiableCredentialEntity credential;
  final bool? isValid;
  final VoidCallback onRevoke;
  final Widget Function(VerifiableCredentialEntity, {bool? isValid})
  cardBuilder;

  @override
  State<_SwipeableCredentialCard> createState() =>
      _SwipeableCredentialCardState();
}

class _SwipeableCredentialCardState extends State<_SwipeableCredentialCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isOpen = false;

  static const double _maxSlideAmount = 100.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-_maxSlideAmount, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final delta = details.primaryDelta ?? 0;
    final newValue = _controller.value - (delta / _maxSlideAmount);
    _controller.value = newValue.clamp(0.0, 1.0);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;

    if (velocity < -500) {
      // Fast swipe to the left - open
      _controller.forward();
      _isOpen = true;
    } else if (velocity > 500) {
      // Fast swipe to the right - close
      _controller.reverse();
      _isOpen = false;
    } else {
      // Slow drag - snap to nearest state
      if (_controller.value > 0.5) {
        _controller.forward();
        _isOpen = true;
      } else {
        _controller.reverse();
        _isOpen = false;
      }
    }
  }

  void _onTap() {
    if (_isOpen) {
      _controller.reverse();
      _isOpen = false;
    }
  }

  void _onRevokeTap() {
    _controller.reverse();
    _isOpen = false;
    widget.onRevoke();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background with revoke button - positioned to match card height
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            width: _maxSlideAmount + 16,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: GestureDetector(
                onTap: _onRevokeTap,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.red),
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete, color: Colors.white, size: 28),
                        SizedBox(height: 4),
                        Text(
                          'Revogar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Foreground card
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: _slideAnimation.value,
                child: child,
              );
            },
            child: GestureDetector(
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              onHorizontalDragEnd: _onHorizontalDragEnd,
              onTap: _onTap,
              child: widget.cardBuilder(
                widget.credential,
                isValid: widget.isValid,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
