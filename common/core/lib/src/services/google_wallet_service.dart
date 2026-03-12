import 'dart:convert';

import 'package:flutter/services.dart';

class GoogleWalletService {
  static const MethodChannel _channel = MethodChannel(
    'com.valid.wallet/provisioning',
  );

  /// Requests the native Android side to provision a credential to Google
  /// Wallet via the Digital Credentials API.
  ///
  /// The [offerJson] must be a JSON string returned by the VTN backend's
  /// `POST /google-wallet/offer` endpoint. It will be restructured to the
  /// W3C Digital Credentials `create()` request format before being passed
  /// to the native CredentialManager.
  Future<bool> addCredentialToWallet(String offerJson) async {
    try {
      final offer = jsonDecode(offerJson) as Map<String, dynamic>;
      final credentialOffer =
          offer['credentialOffer'] as Map<String, dynamic>;

      // Restructure to W3C Digital Credentials create() format
      final requestJson = jsonEncode({
        'requests': [
          {
            'protocol': credentialOffer['protocol'],
            'data': {
              'credential_issuer': credentialOffer['credential_issuer'],
              'grants': credentialOffer['grants'],
            },
          },
        ],
      });

      final result = await _channel.invokeMethod<bool>('addCredential', {
        'offerJson': requestJson,
      });
      return result ?? false;
    } on PlatformException catch (error) {
      print(error);
      return false;
    } catch (_) {
      return false;
    }
  }
}
