// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Valid ID';

  @override
  String get walletTab => 'Wallet';

  @override
  String get scanTab => 'Scan';

  @override
  String get cpfLabel => 'CPF';

  @override
  String get cpfHint => '000.000.000-00';

  @override
  String get cpfRequired => 'CPF is required';

  @override
  String get cpfMustHave11Digits => 'CPF must have 11 digits';

  @override
  String get password => 'Password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMinLength => 'Password must have at least 6 characters';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmPasswordRequired => 'Password confirmation is required';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get signIn => 'Sign in';

  @override
  String get noAccountSignUp => 'Don\'t have an account? Sign up';

  @override
  String get createAccount => 'Create Account';

  @override
  String get signUp => 'Sign up';

  @override
  String get userNotFound => 'User not found';

  @override
  String get userAlreadyRegistered => 'User already registered';

  @override
  String get connectionError => 'Connection error. Please try again';

  @override
  String get timeoutError => 'Timed out. Please try again';

  @override
  String get unexpectedError => 'Unexpected error. Please try again';

  @override
  String get addCredential => 'Add credential';

  @override
  String get noCredentials => 'No credentials';

  @override
  String get credentialsLoadError => 'Error loading credentials';

  @override
  String issuedOn(String date) {
    return 'Issued on: $date';
  }

  @override
  String expiresOn(String date) {
    return 'Expires on: $date';
  }

  @override
  String get statusIssued => 'Issued';

  @override
  String get details => 'Details';

  @override
  String get addToGoogleWallet => 'Add to Google Wallet';

  @override
  String get revokeCredential => 'Revoke Credential';

  @override
  String get information => 'Information';

  @override
  String get credentialDetailError =>
      'Oops, an error occurred. Please try again.';

  @override
  String get credentialRevokedSuccess => 'Credential revoked successfully';

  @override
  String get availableCredentials => 'Available Credentials';

  @override
  String get noOffersAvailable => 'No offers available';

  @override
  String get offersHeaderText =>
      'Here are your documents available for issuance.';

  @override
  String get issue => 'Issue';

  @override
  String get consent => 'Consent';

  @override
  String get consentDescription =>
      'To use the application, we need your consent to collect and process some of your personal data:';

  @override
  String get consentName => 'Name';

  @override
  String get consentDateOfBirth => 'Date of birth';

  @override
  String get consentPurpose => 'Purpose';

  @override
  String get consentPurposeDescription =>
      'Age verification for credential issuance';

  @override
  String get consentLegalBasis => 'Legal Basis';

  @override
  String get consentLegalBasisDescription => 'LGPD Art. 7, I - Consent';

  @override
  String get consentWarning =>
      'Consent is required to continue using the application. You can exit and sign in with another account if you prefer.';

  @override
  String get acceptAndContinue => 'Accept and continue';

  @override
  String get back => 'Back';

  @override
  String get identityVerification => 'Identity Verification';

  @override
  String get livenessVerification => 'Liveness Verification';

  @override
  String get livenessDescription =>
      'To ensure your security and confirm your identity, we need to perform a quick facial verification.';

  @override
  String get startVerification => 'Start Verification';

  @override
  String get cancel => 'Cancel';

  @override
  String get scanQrCode => 'Scan QR Code';

  @override
  String get positionQrCode => 'Position the QR code within the frame';

  @override
  String get shareCredential => 'Share Credential';

  @override
  String get requestedFields => 'Requested fields';

  @override
  String get selectCredential => 'Select credential';

  @override
  String get verificationPurpose => 'Purpose';

  @override
  String get confirmSharing => 'Confirm Sharing';

  @override
  String get sharingSuccess => 'Credential shared successfully';

  @override
  String get sharingError => 'Error sharing credential. Please try again.';

  @override
  String get noActiveCredentials => 'No active credentials available';

  @override
  String get credentialShared => 'Shared';

  @override
  String get documentNotFound => 'Document not found';

  @override
  String get signOut => 'Sign out';

  @override
  String get offersLoadError => 'Error loading offers';

  @override
  String get credentialIssueError =>
      'Error issuing credential. Please try again.';

  @override
  String get credentialTypeAgeVerification => 'Age Verification';

  @override
  String get credentialTypeCofenNursingLicense => 'COFEN Nursing License';
}
