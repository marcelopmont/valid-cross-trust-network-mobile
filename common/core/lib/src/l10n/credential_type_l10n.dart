import 'generated/app_localizations.dart';

String localizedCredentialType(
  AppLocalizations l10n,
  String credentialType,
) {
  return switch (credentialType) {
    'AgeVerificationCredential' => l10n.credentialTypeAgeVerification,
    'CofenNursingLicenseCredential' =>
      l10n.credentialTypeCofenNursingLicense,
    _ => credentialType,
  };
}
