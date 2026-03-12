import 'package:flutter/services.dart';

class GoogleWalletService {
  static const MethodChannel _channel = MethodChannel(
    'com.valid.wallet/provisioning',
  );

  /// Requests the native Android side to provision a credential to Google
  /// Wallet.
  ///
  /// The [offerJson] must be a JSON string formatted according to the
  /// `openid4vci1.0` or Google Digital Credentials provisioning specification.
  Future<bool> addCredentialToWallet(String offerJson) async {
    try {
      final result = await _channel.invokeMethod<bool>('addCredential', {
        'offerJson': offerJson,
      });
      return result ?? false;
    } on PlatformException catch (_) {
      // Return false indicating it failed
      // (e.g. user cancelled, specific wallet error)
      return false;
    } catch (_) {
      return false;
    }
  }
}
