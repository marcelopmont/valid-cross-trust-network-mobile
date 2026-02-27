import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DownloadConfirmationDialog extends StatelessWidget {
  const DownloadConfirmationDialog({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  static Future<void> show(BuildContext context, VoidCallback onConfirm) {
    return showDialog(
      context: context,
      builder: (context) => DownloadConfirmationDialog(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Baixar documento',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      content: const Text(
        'Ao baixar o documento ele ficará disponível offline e você poderá '
        'compartilhá-lo com instituições credenciadas. Caso você já tenha '
        'feito o download desse documento em outro dispositivo, ele será '
        'revogado e só estará disponível nesse aparelho.',
        style: TextStyle(fontSize: 14, height: 1.5),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar', style: TextStyle(color: Colors.grey[600])),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Baixar'),
        ),
      ],
    );
  }
}
