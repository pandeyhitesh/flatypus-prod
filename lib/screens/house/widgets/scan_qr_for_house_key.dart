import 'package:color_log/color_log.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/methods/validations/house_key_validation.dart';
import 'package:flatypus/common/snackbar.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScanQrForHouseKey extends StatefulWidget {
  const ScanQrForHouseKey({super.key});

  @override
  State<ScanQrForHouseKey> createState() => _ScanQrForHouseKeyState();
}

class _ScanQrForHouseKeyState extends State<ScanQrForHouseKey> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    clog.info('inside _onQRViewCreated');
    controller.scannedDataStream.listen((scanData) {
      clog.info('Scanned Data: ${scanData.code}');
      clog.info('is Valid HouseKey: ${isValidHouseKey(scanData.code)}');
      if (isValidHouseKey(scanData.code)) {
        pop(parameter: scanData.code);
      } else {
        showErrorSnackbar(label: 'Invalid House Key');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: QRView(
          key: _qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: AppColors.yellowAccent2,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
          ),
        ),
      ),
    );
  }
}
