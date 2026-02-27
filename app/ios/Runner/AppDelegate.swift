import Flutter
import UIKit
import HubLivenessSDK

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let channelName = "com.valid.didapppoc/liveness"
    private var isInitialized = false
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        guard let controller = window?.rootViewController as? FlutterViewController else {
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
        
        let livenessChannel = FlutterMethodChannel(
            name: channelName,
            binaryMessenger: controller.binaryMessenger
        )
        
        livenessChannel.setMethodCallHandler { [weak self] (call, result) in
            guard let self = self else { return }
            
            switch call.method {
            case "initialize":
                self.handleInitialize(call: call, result: result)
            case "startLivenessCheck":
                self.handleStartLivenessCheck(call: call, result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func handleInitialize(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let apiBaseUrl = args["apiBaseUrl"] as? String,
              let apiKey = args["apiKey"] as? String,
              let appName = args["appName"] as? String,
              let cek = args["cek"] as? String else {
            result(FlutterError(code: "INVALID_ARGS", message: "Missing required configuration parameters", details: nil))
            return
        }
        
        // Parse custom strings
        let stringsMap = args["strings"] as? [String: Any]
        let localization = parseLocalization(stringsMap: stringsMap)
        
        NSLog("[LivenessSDK] Initializing with URL: %@", apiBaseUrl)
        NSLog("[LivenessSDK] CEK length: %d", cek.count)
        
        Task { @MainActor in
            do {
                let config = HubConfig(
                    apiBaseUrl: apiBaseUrl,
                    apiKey: apiKey,
                    appName: appName,
                    cek: cek,
                    localization: localization
                )
                try await HubLiveness.shared.initialize(config: config)
                self.isInitialized = true
                NSLog("[LivenessSDK] Initialization successful")
                result(true)
            } catch let error as HubError {
                NSLog("[LivenessSDK] HubError: %@", error.localizedDescription)
                result(FlutterError(code: "INIT_ERROR", message: error.localizedDescription, details: String(describing: error)))
            } catch {
                NSLog("[LivenessSDK] Error: %@", String(describing: error))
                result(FlutterError(code: "INIT_ERROR", message: "Failed to initialize SDK: \(error.localizedDescription)", details: String(describing: error)))
            }
        }
    }
    
    private func parseLocalization(stringsMap: [String: Any]?) -> HubLocalization {
        guard let stringsMap = stringsMap else {
            return .ptBR
        }
        
        // Parse language
        let languageStr = stringsMap["language"] as? String ?? "ptBr"
        let language: HubSupportedLanguage
        switch languageStr.lowercased() {
        case "en":
            language = .en
        case "es":
            language = .es
        default:
            language = .ptBR
        }
        
        let screensMap = stringsMap["screens"] as? [String: Any] ?? [:]
        let feedbackMap = stringsMap["feedback"] as? [String: Any] ?? [:]
        let buttonsMap = stringsMap["buttons"] as? [String: Any] ?? [:]
        
        // Check if there are any custom strings
        let hasCustomScreens = screensMap.values.contains { $0 is String }
        let hasCustomFeedback = feedbackMap.values.contains { $0 is String }
        let hasCustomButtons = buttonsMap.values.contains { $0 is String }
        
        if !hasCustomScreens && !hasCustomFeedback && !hasCustomButtons {
            // No custom strings, use default based on language
            return HubLocalization(language: language, customStrings: nil)
        }
        
        // Parse screen strings
        let screenStrings = HubScreenStrings(
            captureTitle: screensMap["captureTitle"] as? String,
            captureHelpText: screensMap["captureHelpText"] as? String,
            loadingText: screensMap["loadingText"] as? String,
            reviewPhotoTitle: screensMap["reviewPhotoTitle"] as? String,
            reviewPhotoInstruction: screensMap["reviewPhotoInstruction"] as? String,
            getReadyTitle: screensMap["getReadyTitle"] as? String,
            getReadySubtitle: screensMap["getReadySubtitle"] as? String,
            getReadyMessage: screensMap["getReadyMessage"] as? String,
            getReadyMessageLine2: screensMap["getReadyMessageLine2"] as? String,
            retryTitle: screensMap["retryTitle"] as? String,
            retrySubtitle: screensMap["retrySubtitle"] as? String,
            retryTip1: screensMap["retryTip1"] as? String,
            retryTip2: screensMap["retryTip2"] as? String,
            yourImageLabel: screensMap["yourImageLabel"] as? String,
            idealImageLabel: screensMap["idealImageLabel"] as? String,
            uploadingMessage: screensMap["uploadingMessage"] as? String,
            uploadingSlowConnection: screensMap["uploadingSlowConnection"] as? String,
            successMessage: screensMap["successMessage"] as? String
        )
        
        // Parse feedback strings
        let feedbackStrings = HubFeedbackStrings(
            noFaceDetected: feedbackMap["noFaceDetected"] as? String,
            multipleFaces: feedbackMap["multipleFaces"] as? String,
            faceCentered: feedbackMap["faceCentered"] as? String,
            tooClose: feedbackMap["tooClose"] as? String,
            tooFar: feedbackMap["tooFar"] as? String,
            tooLeft: feedbackMap["tooLeft"] as? String,
            tooRight: feedbackMap["tooRight"] as? String,
            tooHigh: feedbackMap["tooHigh"] as? String,
            tooLow: feedbackMap["tooLow"] as? String,
            moveToEyeLevel: feedbackMap["moveToEyeLevel"] as? String,
            invalidIED: feedbackMap["invalidIED"] as? String,
            faceAngleMisaligned: feedbackMap["faceAngleMisaligned"] as? String,
            lookStraightAhead: feedbackMap["lookStraightAhead"] as? String,
            holdHeadStraight: feedbackMap["holdHeadStraight"] as? String,
            closedEyes: feedbackMap["closedEyes"] as? String,
            smiling: feedbackMap["smiling"] as? String,
            neutralExpression: feedbackMap["neutralExpression"] as? String,
            removeDarkGlasses: feedbackMap["removeDarkGlasses"] as? String,
            tooDark: feedbackMap["tooDark"] as? String,
            tooBright: feedbackMap["tooBright"] as? String,
            lightFaceEvenly: feedbackMap["lightFaceEvenly"] as? String,
            brightenEnvironment: feedbackMap["brightenEnvironment"] as? String,
            holdSteady: feedbackMap["holdSteady"] as? String,
            frameYourFace: feedbackMap["frameYourFace"] as? String
        )
        
        // Parse button strings
        let buttonStrings = HubButtonStrings(
            back: buttonsMap["back"] as? String,
            capture: buttonsMap["capture"] as? String,
            retake: buttonsMap["retake"] as? String,
            submit: buttonsMap["submit"] as? String,
            switchCamera: buttonsMap["switchCamera"] as? String,
            flashOn: buttonsMap["flashOn"] as? String,
            flashOff: buttonsMap["flashOff"] as? String,
            imReady: buttonsMap["imReady"] as? String,
            tryAgain: buttonsMap["tryAgain"] as? String,
            ok: buttonsMap["ok"] as? String,
            continueButton: buttonsMap["continueButton"] as? String
        )
        
        let customStrings = HubStrings(
            screens: screenStrings,
            feedback: feedbackStrings,
            buttons: buttonStrings
        )
        
        return HubLocalization(language: language, customStrings: customStrings)
    }
    
    private func handleStartLivenessCheck(call: FlutterMethodCall, result: @escaping FlutterResult) {
        NSLog("[LivenessSDK] handleStartLivenessCheck called, isInitialized: %@", isInitialized ? "true" : "false")
        
        guard isInitialized else {
            NSLog("[LivenessSDK] SDK not initialized!")
            result(FlutterError(code: "NOT_INITIALIZED", message: "SDK not initialized. Call initialize first.", details: nil))
            return
        }
        
        let args = call.arguments as? [String: Any]
        let riskLevelStr = args?["riskLevel"] as? String ?? "medium"
        
        NSLog("[LivenessSDK] Starting liveness with risk level: %@", riskLevelStr)
        
        let riskLevel: HubRiskLevel
        switch riskLevelStr.lowercased() {
        case "low":
            riskLevel = .low
        case "high":
            riskLevel = .high
        default:
            riskLevel = .medium
        }
        
        Task { @MainActor in
            do {
                NSLog("[LivenessSDK] Calling HubLiveness.shared.startLiveness...")
                try await HubLiveness.shared.startLiveness(riskLevel: riskLevel) { livenessResult in
                    NSLog("[LivenessSDK] Liveness callback received")
                    DispatchQueue.main.async {
                        switch livenessResult {
                        case .success(let data):
                            NSLog("[LivenessSDK] Liveness SUCCESS")
                            result([
                                "success": true,
                                "sessionId": data.sessionId ?? "",
                                "livenessScore": data.livenessScore ?? 0.0
                            ])
                        case .failure(let error):
                            NSLog("[LivenessSDK] Liveness FAILURE: %@", error.localizedDescription)
                            result(FlutterError(code: "LIVENESS_FAILED", message: error.localizedDescription, details: nil))
                        case .cancelled:
                            NSLog("[LivenessSDK] Liveness CANCELLED")
                            result(FlutterError(code: "LIVENESS_CANCELLED", message: "Liveness check was cancelled", details: nil))
                        }
                    }
                }
            } catch {
                NSLog("[LivenessSDK] Liveness ERROR: %@", String(describing: error))
                result(FlutterError(code: "LIVENESS_ERROR", message: "Error during liveness check: \(error.localizedDescription)", details: nil))
            }
        }
    }
}
