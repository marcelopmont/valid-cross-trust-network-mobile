import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Valid ID'**
  String get appTitle;

  /// No description provided for @walletTab.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletTab;

  /// No description provided for @scanTab.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scanTab;

  /// No description provided for @cpfLabel.
  ///
  /// In en, this message translates to:
  /// **'CPF'**
  String get cpfLabel;

  /// No description provided for @cpfHint.
  ///
  /// In en, this message translates to:
  /// **'000.000.000-00'**
  String get cpfHint;

  /// No description provided for @cpfRequired.
  ///
  /// In en, this message translates to:
  /// **'CPF is required'**
  String get cpfRequired;

  /// No description provided for @cpfMustHave11Digits.
  ///
  /// In en, this message translates to:
  /// **'CPF must have 11 digits'**
  String get cpfMustHave11Digits;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must have at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation is required'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @noAccountSignUp.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up'**
  String get noAccountSignUp;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @userAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'User already registered'**
  String get userAlreadyRegistered;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection error. Please try again'**
  String get connectionError;

  /// No description provided for @timeoutError.
  ///
  /// In en, this message translates to:
  /// **'Timed out. Please try again'**
  String get timeoutError;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error. Please try again'**
  String get unexpectedError;

  /// No description provided for @addCredential.
  ///
  /// In en, this message translates to:
  /// **'Add credential'**
  String get addCredential;

  /// No description provided for @noCredentials.
  ///
  /// In en, this message translates to:
  /// **'No credentials'**
  String get noCredentials;

  /// No description provided for @credentialsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading credentials'**
  String get credentialsLoadError;

  /// No description provided for @issuedOn.
  ///
  /// In en, this message translates to:
  /// **'Issued on: {date}'**
  String issuedOn(String date);

  /// No description provided for @expiresOn.
  ///
  /// In en, this message translates to:
  /// **'Expires on: {date}'**
  String expiresOn(String date);

  /// No description provided for @statusIssued.
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get statusIssued;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @addToGoogleWallet.
  ///
  /// In en, this message translates to:
  /// **'Add to Google Wallet'**
  String get addToGoogleWallet;

  /// No description provided for @revokeCredential.
  ///
  /// In en, this message translates to:
  /// **'Revoke Credential'**
  String get revokeCredential;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @credentialDetailError.
  ///
  /// In en, this message translates to:
  /// **'Oops, an error occurred. Please try again.'**
  String get credentialDetailError;

  /// No description provided for @credentialRevokedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Credential revoked successfully'**
  String get credentialRevokedSuccess;

  /// No description provided for @availableCredentials.
  ///
  /// In en, this message translates to:
  /// **'Available Credentials'**
  String get availableCredentials;

  /// No description provided for @noOffersAvailable.
  ///
  /// In en, this message translates to:
  /// **'No offers available'**
  String get noOffersAvailable;

  /// No description provided for @offersHeaderText.
  ///
  /// In en, this message translates to:
  /// **'Here are your documents available for issuance.'**
  String get offersHeaderText;

  /// No description provided for @issue.
  ///
  /// In en, this message translates to:
  /// **'Issue'**
  String get issue;

  /// No description provided for @consent.
  ///
  /// In en, this message translates to:
  /// **'Consent'**
  String get consent;

  /// No description provided for @consentDescription.
  ///
  /// In en, this message translates to:
  /// **'To use the application, we need your consent to collect and process some of your personal data:'**
  String get consentDescription;

  /// No description provided for @consentName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get consentName;

  /// No description provided for @consentDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get consentDateOfBirth;

  /// No description provided for @consentPurpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get consentPurpose;

  /// No description provided for @consentPurposeDescription.
  ///
  /// In en, this message translates to:
  /// **'Age verification for credential issuance'**
  String get consentPurposeDescription;

  /// No description provided for @consentLegalBasis.
  ///
  /// In en, this message translates to:
  /// **'Legal Basis'**
  String get consentLegalBasis;

  /// No description provided for @consentLegalBasisDescription.
  ///
  /// In en, this message translates to:
  /// **'LGPD Art. 7, I - Consent'**
  String get consentLegalBasisDescription;

  /// No description provided for @consentWarning.
  ///
  /// In en, this message translates to:
  /// **'Consent is required to continue using the application. You can exit and sign in with another account if you prefer.'**
  String get consentWarning;

  /// No description provided for @acceptAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Accept and continue'**
  String get acceptAndContinue;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @identityVerification.
  ///
  /// In en, this message translates to:
  /// **'Identity Verification'**
  String get identityVerification;

  /// No description provided for @livenessVerification.
  ///
  /// In en, this message translates to:
  /// **'Liveness Verification'**
  String get livenessVerification;

  /// No description provided for @livenessDescription.
  ///
  /// In en, this message translates to:
  /// **'To ensure your security and confirm your identity, we need to perform a quick facial verification.'**
  String get livenessDescription;

  /// No description provided for @startVerification.
  ///
  /// In en, this message translates to:
  /// **'Start Verification'**
  String get startVerification;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQrCode;

  /// No description provided for @positionQrCode.
  ///
  /// In en, this message translates to:
  /// **'Position the QR code within the frame'**
  String get positionQrCode;

  /// No description provided for @documentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Document not found'**
  String get documentNotFound;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @offersLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading offers'**
  String get offersLoadError;

  /// No description provided for @credentialIssueError.
  ///
  /// In en, this message translates to:
  /// **'Error issuing credential. Please try again.'**
  String get credentialIssueError;

  /// No description provided for @credentialTypeAgeVerification.
  ///
  /// In en, this message translates to:
  /// **'Age Verification'**
  String get credentialTypeAgeVerification;

  /// No description provided for @credentialTypeCofenNursingLicense.
  ///
  /// In en, this message translates to:
  /// **'COFEN Nursing License'**
  String get credentialTypeCofenNursingLicense;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
