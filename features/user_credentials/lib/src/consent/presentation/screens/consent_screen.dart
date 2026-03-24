import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ConsentScreen extends StatelessWidget {
  const ConsentScreen({
    super.key,
    required this.isGranting,
    required this.showDeclinedMessage,
    required this.onAccept,
    required this.onGoBack,
  });

  final bool isGranting;
  final bool showDeclinedMessage;
  final VoidCallback onAccept;
  final VoidCallback onGoBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Icon(
                Icons.privacy_tip_outlined,
                size: 64,
                color: AppColors.primary,
              ),
              const SizedBox(height: 24),
              const Text(
                'Consentimento LGPD',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Para utilizar o aplicativo, precisamos do '
                'seu consentimento para coletar e processar '
                'os seguintes dados pessoais:',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildDataItem(Icons.person_outline, 'Nome completo'),
              _buildDataItem(Icons.badge_outlined, 'CPF'),
              _buildDataItem(
                Icons.calendar_today_outlined,
                'Data de nascimento',
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Finalidade',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Verificação de identidade para '
                      'abertura de conta',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Base Legal',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'LGPD Art. 7, I - Consentimento',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (showDeclinedMessage)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: const Text(
                    'O consentimento é obrigatório para '
                    'continuar utilizando o aplicativo. '
                    'Você pode sair e entrar com outra conta '
                    'se preferir.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ValidButton(
                label: 'Aceitar e continuar',
                onPressed: isGranting ? null : onAccept,
                isLoading: isGranting,
              ),
              const SizedBox(height: 12),
              TextButton(onPressed: onGoBack, child: const Text('Voltar')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
