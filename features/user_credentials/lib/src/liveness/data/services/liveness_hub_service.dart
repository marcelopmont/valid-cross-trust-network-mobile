import 'package:flutter/services.dart';

enum LivenessRiskLevel { low, medium, high }

class ScreenStrings {
  const ScreenStrings({
    this.captureTitle,
    this.captureHelpText,
    this.loadingText,
    this.getReadyTitle,
    this.getReadySubtitle,
    this.getReadyMessage,
    this.getReadyMessageLine2,
    this.retryTitle,
    this.retrySubtitle,
    this.retryTip1,
    this.retryTip2,
    this.yourImageLabel,
    this.idealImageLabel,
    this.reviewPhotoTitle,
    this.reviewPhotoInstruction,
    this.uploadingMessage,
    this.uploadingSlowConnection,
    this.successMessage,
  });

  final String? captureTitle;
  final String? captureHelpText;
  final String? loadingText;
  final String? getReadyTitle;
  final String? getReadySubtitle;
  final String? getReadyMessage;
  final String? getReadyMessageLine2;
  final String? retryTitle;
  final String? retrySubtitle;
  final String? retryTip1;
  final String? retryTip2;
  final String? yourImageLabel;
  final String? idealImageLabel;
  final String? reviewPhotoTitle;
  final String? reviewPhotoInstruction;
  final String? uploadingMessage;
  final String? uploadingSlowConnection;
  final String? successMessage;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (captureTitle != null) map['captureTitle'] = captureTitle;
    if (captureHelpText != null) map['captureHelpText'] = captureHelpText;
    if (loadingText != null) map['loadingText'] = loadingText;
    if (getReadyTitle != null) map['getReadyTitle'] = getReadyTitle;
    if (getReadySubtitle != null) map['getReadySubtitle'] = getReadySubtitle;
    if (getReadyMessage != null) map['getReadyMessage'] = getReadyMessage;
    if (getReadyMessageLine2 != null) {
      map['getReadyMessageLine2'] = getReadyMessageLine2;
    }
    if (retryTitle != null) map['retryTitle'] = retryTitle;
    if (retrySubtitle != null) map['retrySubtitle'] = retrySubtitle;
    if (retryTip1 != null) map['retryTip1'] = retryTip1;
    if (retryTip2 != null) map['retryTip2'] = retryTip2;
    if (yourImageLabel != null) map['yourImageLabel'] = yourImageLabel;
    if (idealImageLabel != null) map['idealImageLabel'] = idealImageLabel;
    if (reviewPhotoTitle != null) map['reviewPhotoTitle'] = reviewPhotoTitle;
    if (reviewPhotoInstruction != null) {
      map['reviewPhotoInstruction'] = reviewPhotoInstruction;
    }
    if (uploadingMessage != null) map['uploadingMessage'] = uploadingMessage;
    if (uploadingSlowConnection != null) {
      map['uploadingSlowConnection'] = uploadingSlowConnection;
    }
    if (successMessage != null) map['successMessage'] = successMessage;
    return map;
  }
}

class FeedbackStrings {
  const FeedbackStrings({
    this.noFaceDetected,
    this.multipleFaces,
    this.faceCentered,
    this.tooClose,
    this.tooFar,
    this.tooLeft,
    this.tooRight,
    this.tooHigh,
    this.tooLow,
    this.moveToEyeLevel,
    this.invalidIED,
    this.faceAngleMisaligned,
    this.lookStraightAhead,
    this.holdHeadStraight,
    this.closedEyes,
    this.smiling,
    this.neutralExpression,
    this.removeDarkGlasses,
    this.tooDark,
    this.tooBright,
    this.lightFaceEvenly,
    this.brightenEnvironment,
    this.holdSteady,
    this.frameYourFace,
  });

  final String? noFaceDetected;
  final String? multipleFaces;
  final String? faceCentered;
  final String? tooClose;
  final String? tooFar;
  final String? tooLeft;
  final String? tooRight;
  final String? tooHigh;
  final String? tooLow;
  final String? moveToEyeLevel;
  final String? invalidIED;
  final String? faceAngleMisaligned;
  final String? lookStraightAhead;
  final String? holdHeadStraight;
  final String? closedEyes;
  final String? smiling;
  final String? neutralExpression;
  final String? removeDarkGlasses;
  final String? tooDark;
  final String? tooBright;
  final String? lightFaceEvenly;
  final String? brightenEnvironment;
  final String? holdSteady;
  final String? frameYourFace;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (noFaceDetected != null) map['noFaceDetected'] = noFaceDetected;
    if (multipleFaces != null) map['multipleFaces'] = multipleFaces;
    if (faceCentered != null) map['faceCentered'] = faceCentered;
    if (tooClose != null) map['tooClose'] = tooClose;
    if (tooFar != null) map['tooFar'] = tooFar;
    if (tooLeft != null) map['tooLeft'] = tooLeft;
    if (tooRight != null) map['tooRight'] = tooRight;
    if (tooHigh != null) map['tooHigh'] = tooHigh;
    if (tooLow != null) map['tooLow'] = tooLow;
    if (moveToEyeLevel != null) map['moveToEyeLevel'] = moveToEyeLevel;
    if (invalidIED != null) map['invalidIED'] = invalidIED;
    if (faceAngleMisaligned != null) {
      map['faceAngleMisaligned'] = faceAngleMisaligned;
    }
    if (lookStraightAhead != null) map['lookStraightAhead'] = lookStraightAhead;
    if (holdHeadStraight != null) map['holdHeadStraight'] = holdHeadStraight;
    if (closedEyes != null) map['closedEyes'] = closedEyes;
    if (smiling != null) map['smiling'] = smiling;
    if (neutralExpression != null) map['neutralExpression'] = neutralExpression;
    if (removeDarkGlasses != null) map['removeDarkGlasses'] = removeDarkGlasses;
    if (tooDark != null) map['tooDark'] = tooDark;
    if (tooBright != null) map['tooBright'] = tooBright;
    if (lightFaceEvenly != null) map['lightFaceEvenly'] = lightFaceEvenly;
    if (brightenEnvironment != null) {
      map['brightenEnvironment'] = brightenEnvironment;
    }
    if (holdSteady != null) map['holdSteady'] = holdSteady;
    if (frameYourFace != null) map['frameYourFace'] = frameYourFace;
    return map;
  }
}

class ButtonStrings {
  const ButtonStrings({
    this.back,
    this.capture,
    this.switchCamera,
    this.flashOn,
    this.flashOff,
    this.imReady,
    this.tryAgain,
    this.ok,
    this.continueButton,
    this.retake,
    this.submit,
  });

  final String? back;
  final String? capture;
  final String? switchCamera;
  final String? flashOn;
  final String? flashOff;
  final String? imReady;
  final String? tryAgain;
  final String? ok;
  final String? continueButton;
  final String? retake;
  final String? submit;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (back != null) map['back'] = back;
    if (capture != null) map['capture'] = capture;
    if (switchCamera != null) map['switchCamera'] = switchCamera;
    if (flashOn != null) map['flashOn'] = flashOn;
    if (flashOff != null) map['flashOff'] = flashOff;
    if (imReady != null) map['imReady'] = imReady;
    if (tryAgain != null) map['tryAgain'] = tryAgain;
    if (ok != null) map['ok'] = ok;
    if (continueButton != null) map['continueButton'] = continueButton;
    if (retake != null) map['retake'] = retake;
    if (submit != null) map['submit'] = submit;
    return map;
  }
}

/// Supported languages for liveness localization.
enum SupportedLanguage { en, ptBr, es }

class LivenessStrings {
  const LivenessStrings({
    this.language = SupportedLanguage.ptBr,
    this.screens = const ScreenStrings(),
    this.feedback = const FeedbackStrings(),
    this.buttons = const ButtonStrings(),
  });

  /// Base language for strings (defaults will be taken from this language).
  final SupportedLanguage language;

  /// Custom screen strings (override defaults).
  final ScreenStrings screens;

  /// Custom feedback strings (override defaults).
  final FeedbackStrings feedback;

  /// Custom button strings (override defaults).
  final ButtonStrings buttons;

  Map<String, dynamic> toMap() => {
    'language': language.name,
    'screens': screens.toMap(),
    'feedback': feedback.toMap(),
    'buttons': buttons.toMap(),
  };
}

class LivenessHubConfig {
  const LivenessHubConfig({
    required this.apiBaseUrl,
    required this.apiKey,
    required this.appName,
    required this.cek,
    this.strings = const LivenessStrings(),
  });

  final String apiBaseUrl;
  final String apiKey;
  final String appName;
  final String cek;
  final LivenessStrings strings;

  static const LivenessHubConfig production = LivenessHubConfig(
    apiBaseUrl: 'https://hml-api.hub-liveness-service.app',
    apiKey:
        '''sk_key604fabe1ce9cc727dd33f70f89341ace_b8dddf784c89603bbc27532b8d676288e5956c4714a5df4af6064f6209a8b2d7''',
    appName: 'HUB Sample',
    cek:
        '''eyJ2ZXJzaW9uIjoiMS4wIiwicHJvamVjdElkIjoiMDE5YWNiNzUtZGFhZi03NTllLWFjMzktNGVmZWU3NDgyZDQ3Iiwia2V5SWQiOiJjZWstMTc2Nzk5MTQ0MDA4MC1iNGZiY2FkYSIsImFsZ29yaXRobSI6IkFFUy0yNTYtR0NNIiwiZW5jcnlwdGlvbktleSI6InZQa012YjdBODF1QVJYVmhOWEFOMjBoYzdsQzBDWFAyZjFvRVNUdGhlOE09IiwiY3JlYXRlZEF0IjoiMjAyNi0wMS0wOVQyMDo0NDowMC4wODBaIiwiZXhwaXJlc0F0IjoiMjAyNy0wMS0wOVQyMDo0NDowMC4wODBaIiwibWV0YWRhdGEiOnsibmFtZSI6IkNFSyBmb3IgMDE5YWNiNzUtZGFhZi03NTllLWFjMzktNGVmZWU3NDgyZDQ3IiwiZW52aXJvbm1lbnQiOiJwcm9kdWN0aW9uIiwiZGVzY3JpcHRpb24iOiJHZW5lcmF0ZWQgdmlhIGNyZWF0ZS1wcm9qZWN0LWVudmlyb25tZW50IEFQSSJ9LCJzaWduYXR1cmUiOnsiYWxnb3JpdGhtIjoiSE1BQy1TSEEyNTYiLCJ2YWx1ZSI6ImQwOTJiYzk1M2VhM2Y1OGRjMWM3ZDc4NTYyODMyODk5ZmIyMGM1ODkzODk2ZDZmNjc5ODgzY2I0NWU0OWExZWIiLCJ0aW1lc3RhbXAiOiIyMDI2LTAxLTA5VDIwOjQ0OjAwLjA4MFoifX0=''',
    strings: LivenessStrings(language: SupportedLanguage.ptBr),
  );

  Map<String, dynamic> toMap() {
    return {
      'apiBaseUrl': apiBaseUrl,
      'apiKey': apiKey,
      'appName': appName,
      'cek': cek,
      'strings': strings.toMap(),
    };
  }
}

class LivenessHubService {
  static const MethodChannel _channel = MethodChannel(
    'com.valid.didapppoc/liveness',
  );

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<bool> initialize([
    LivenessHubConfig config = LivenessHubConfig.production,
  ]) async {
    if (_isInitialized) return true;

    try {
      final result = await _channel.invokeMethod<bool>(
        'initialize',
        config.toMap(),
      );
      return _isInitialized = result ?? false;
    } on PlatformException catch (e) {
      throw LivenessHubException(
        code: e.code,
        message: e.message ?? 'Failed to initialize SDK',
      );
    }
  }

  Future<bool> startLivenessCheck({
    LivenessRiskLevel riskLevel = LivenessRiskLevel.medium,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'startLivenessCheck',
        {'riskLevel': riskLevel.name},
      );
      return result?['success'] == true;
    } on PlatformException catch (e) {
      throw LivenessHubException(
        code: e.code,
        message: e.message ?? 'Liveness check failed',
      );
    }
  }
}

class LivenessHubException implements Exception {
  LivenessHubException({required this.code, required this.message});

  final String code;
  final String message;

  @override
  String toString() => 'LivenessHubException($code): $message';
}
