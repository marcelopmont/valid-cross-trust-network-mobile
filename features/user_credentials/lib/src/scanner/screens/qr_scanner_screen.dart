import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool _isProcessing = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isProcessing) return;

    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final barcode = barcodes.first;
    final code = barcode.rawValue;

    if (code != null && code.isNotEmpty) {
      setState(() {
        _isProcessing = true;
      });

      context.go('/credentials', extra: {'qrCode': code});
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isProcessing = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    final scanArea = (size.width < 400 || size.height < 400) ? 280.0 : 400.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: ValidAppBar(
        titleText: l10n.scanQrCode,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/credentials');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              const code =
                  '''https://verifier-api-82152658351.us-central1.run.app?_oob=eyJ0eXBlIjoiaHR0cHM6Ly9kaWRjb21tLm9yZy9vdXQtb2YtYmFuZC8yLjAvaW52aXRhdGlvbiIsImlkIjoidXJuOnV1aWQ6MTI5Y2VkNjYtY2JmZS00MTc5LTkzZmYtMGRmM2QzMjczOGU1IiwiZnJvbSI6ImRpZDp3ZWI6dmVyaWZpZXItYXBpLTgyMTUyNjU4MzUxLnVzLWNlbnRyYWwxLnJ1bi5hcHAiLCJib2R5Ijp7ImdvYWxfY29kZSI6InN0cmVhbWxpbmVkLXZwIiwiZ29hbCI6IlZlcmlmaWNhciBoYWJpbGl0YWNhbyBwcm9maXNzaW9uYWwgZGUgZW5mZXJtYWdlbSIsImFjY2VwdCI6WyJkaWRjb21tL3YyIl19LCJhdHRhY2htZW50cyI6W3siaWQiOiJyZXF1ZXN0LTAiLCJtZWRpYV90eXBlIjoiYXBwbGljYXRpb24vanNvbiIsImZvcm1hdCI6ImRpZi9wcmVzZW50YXRpb24tZXhjaGFuZ2UvZGVmaW5pdGlvbnNAdjIuMCIsImRhdGEiOnsianNvbiI6eyJvcHRpb25zIjp7ImNoYWxsZW5nZSI6ImNkMjdjOGUxLTFkNWYtNDA5ZS1hMGViLTA3MjZlMDE2YTlmMiIsImRvbWFpbiI6InZlcmlmaWVyLWFwaS04MjE1MjY1ODM1MS51cy1jZW50cmFsMS5ydW4uYXBwIn0sInByZXNlbnRhdGlvbl9kZWZpbml0aW9uIjp7ImlkIjoibnVyc2luZy1saWNlbnNlLXZlcmlmaWNhdGlvbiIsibmFtZSI6IlZlcmlmaWNhY2FvIGRlIEVuZmVybWVpcm8iLCJwdXJwb3NlIjoiVmVyaWZpY2FyIGhhYmlsaXRhY2FvIHByb2Zpc3Npb25hbCBwYXJhIGFjZXNzbyBhbyBob3NwaXRhbCIsImlucHV0X2Rlc2NyaXB0b3JzIjpbeyJpZCI6Im51cnNpbmctbGljZW5zZSIsIm5hbWUiOiJMaWNlbmNhIGRlIEVuZmVybWFnZW0gQ09GRU4iLCJwdXJwb3NlIjoiVmVyaWZpY2FyIHJlZ2lzdHJvIGF0aXZvIG5vIENPRkVOIiwiY29uc3RyYWludHMiOnsibGltaXRfZGlzY2xvc3VyZSI6InJlcXVpcmVkIiwiZmllbGRzIjpbeyJwYXRoIjpbIiQudHlwZSJdLCJmaWx0ZXIiOnsidHlwZSI6ImFycmF5IiwiY29udGFpbnMiOnsiY29uc3QiOiJDb2Zlbk51cnNpbmdMaWNlbnNlQ3JlZGVudGlhbCJ9fX0seyJwYXRoIjpbIiQuY3JlZGVudGlhbFN1YmplY3QubGljZW5zZVR5cGUiXSwicHVycG9zZSI6IlRpcG8gZGUgaGFiaWxpdGFjYW8ifSx7InBhdGgiOlsiJC5jcmVkZW50aWFsU3ViamVjdC5yZWdpc3RyYXRpb25OdW1iZXIiXSwicHVycG9zZSI6Ik51bWVybyBkZSByZWdpc3RybyBDT0ZFTiJ9LHsicGF0aCI6WyIkLmNyZWRlbnRpYWxTdWJqZWN0LnJlZ2lzdHJhdGlvblN0YXRlIl0sInB1cnBvc2UiOiJFc3RhZG8gZG8gcmVnaXN0cm8ifSx7InBhdGgiOlsiJC5jcmVkZW50aWFsU3ViamVjdC5ob2xkZXJOYW1lIl0sInB1cnBvc2UiOiJOb21lIGRvIHByb2Zpc3Npb25hbCJ9LHsicGF0aCI6WyIkLmNyZWRlbnRpYWxTdWJqZWN0LmV4cGlyYXRpb25EYXRlIl0sInB1cnBvc2UiOiJWYWxpZGFkZSBkbyByZWdpc3RybyJ9XX19XX19fX19XSwiY3JlYXRlZF90aW1lIjoiMjAyNS0xMi0wOVQxOTo1OTo0Ni41NDNaIn0''';
              context.go('/credentials', extra: {'qrCode': code});
            },
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(controller: cameraController, onDetect: _onDetect),
          CustomPaint(
            painter: ScannerOverlayPainter(scanArea: scanArea),
            child: const SizedBox.expand(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 60),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                l10n.positionQrCode,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  const ScannerOverlayPainter({required this.scanArea});

  final double scanArea;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: scanArea,
            height: scanArea,
          ),
          const Radius.circular(12),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.srcOver;

    canvas.drawPath(
      Path.combine(PathOperation.difference, backgroundPath, cutoutPath),
      backgroundPaint,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final left = (size.width - scanArea) / 2;
    final top = (size.height - scanArea) / 2;
    final right = left + scanArea;
    final bottom = top + scanArea;
    const cornerSize = 20.0;

    canvas.drawLine(
      Offset(left, top),
      Offset(left + cornerSize, top),
      borderPaint,
    );
    canvas.drawLine(
      Offset(left, top),
      Offset(left, top + cornerSize),
      borderPaint,
    );

    canvas.drawLine(
      Offset(right, top),
      Offset(right - cornerSize, top),
      borderPaint,
    );
    canvas.drawLine(
      Offset(right, top),
      Offset(right, top + cornerSize),
      borderPaint,
    );

    canvas.drawLine(
      Offset(left, bottom),
      Offset(left + cornerSize, bottom),
      borderPaint,
    );
    canvas.drawLine(
      Offset(left, bottom),
      Offset(left, bottom - cornerSize),
      borderPaint,
    );

    canvas.drawLine(
      Offset(right, bottom),
      Offset(right - cornerSize, bottom),
      borderPaint,
    );
    canvas.drawLine(
      Offset(right, bottom),
      Offset(right, bottom - cornerSize),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
