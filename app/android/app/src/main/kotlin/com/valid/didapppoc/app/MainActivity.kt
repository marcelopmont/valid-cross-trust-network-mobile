package com.valid.didapppoc.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.launch
import com.valid.entry.LivenessHubSDK
import com.valid.entry.models.LivenessHubConfig
import com.valid.entry.models.LivenessHubRiskLevel
import com.valid.models.localization.LivenessLocalization
import com.valid.models.localization.LivenessStrings
import com.valid.models.localization.ScreenStrings
import com.valid.models.localization.FeedbackStrings
import com.valid.models.localization.ButtonStrings
import com.valid.models.localization.SupportedLanguage

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.valid.didapppoc/liveness"
    private var isInitialized = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "initialize" -> {
                    val apiBaseUrl = call.argument<String>("apiBaseUrl")
                    val apiKey = call.argument<String>("apiKey")
                    val appName = call.argument<String>("appName")
                    val cek = call.argument<String>("cek")
                    val stringsMap = call.argument<Map<String, Any?>>("strings")

                    if (apiBaseUrl != null && apiKey != null && appName != null && cek != null) {
                        try {
                            // Parse custom localization from strings
                            val localization = parseLocalization(stringsMap)
                            
                            val config = LivenessHubConfig(
                                apiBaseUrl = apiBaseUrl,
                                apiKey = apiKey,
                                appName = appName,
                                cek = cek,
                                localization = localization
                            )
                            LivenessHubSDK.init(applicationContext, config)
                            
                            isInitialized = true
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("INIT_ERROR", "Failed to initialize SDK: ${e.message}", null)
                        }
                    } else {
                        result.error("INVALID_ARGS", "Missing required configuration parameters", null)
                    }
                }
                "startLivenessCheck" -> {
                    if (!isInitialized) {
                        result.error("NOT_INITIALIZED", "SDK not initialized. Call initialize first.", null)
                        return@setMethodCallHandler
                    }

                    val riskLevelStr = call.argument<String>("riskLevel") ?: "medium"
                    val riskLevel = when (riskLevelStr.lowercase()) {
                        "low" -> LivenessHubRiskLevel.LIVENESS_RISK_LOW
                        "high" -> LivenessHubRiskLevel.LIVENESS_RISK_HIGH
                        else -> LivenessHubRiskLevel.LIVENESS_RISK_MEDIUM
                    }

                    lifecycleScope.launch {
                        try {
                            val livenessResult = LivenessHubSDK.startLivenessCheck(
                                this@MainActivity,
                                riskLevel
                            )
                            livenessResult.onSuccess {
                                result.success(mapOf("success" to true))
                            }.onFailure { error ->
                                result.error("LIVENESS_FAILED", error.message ?: "Liveness check failed", null)
                            }
                        } catch (e: Exception) {
                            result.error("LIVENESS_ERROR", "Error during liveness check: ${e.message}", null)
                        }
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun parseLocalization(stringsMap: Map<String, Any?>?): LivenessLocalization {
        if (stringsMap == null) {
            return LivenessLocalization.Companion.portugueseBrazil()
        }

        val languageStr = stringsMap["language"] as? String ?: "ptBr"
        val language = when (languageStr.lowercase()) {
            "en" -> SupportedLanguage.EN
            "es" -> SupportedLanguage.ES
            else -> SupportedLanguage.PT_BR
        }

        val screensMap = stringsMap["screens"] as? Map<String, Any?> ?: emptyMap()
        val feedbackMap = stringsMap["feedback"] as? Map<String, Any?> ?: emptyMap()
        val buttonsMap = stringsMap["buttons"] as? Map<String, Any?> ?: emptyMap()

        // Only create custom strings if there are actual custom values
        val hasCustomScreens = screensMap.values.any { it != null }
        val hasCustomFeedback = feedbackMap.values.any { it != null }
        val hasCustomButtons = buttonsMap.values.any { it != null }

        if (!hasCustomScreens && !hasCustomFeedback && !hasCustomButtons) {
            return when (language) {
                SupportedLanguage.EN -> LivenessLocalization.Companion.default()
                SupportedLanguage.ES -> LivenessLocalization.Companion.spanish()
                else -> LivenessLocalization.Companion.portugueseBrazil()
            }
        }

        val screenStrings = ScreenStrings(
            captureTitle = screensMap["captureTitle"] as? String,
            captureHelpText = screensMap["captureHelpText"] as? String,
            loadingText = screensMap["loadingText"] as? String,
            getReadyTitle = screensMap["getReadyTitle"] as? String,
            getReadySubtitle = screensMap["getReadySubtitle"] as? String,
            getReadyMessage = screensMap["getReadyMessage"] as? String,
            getReadyMessageLine2 = screensMap["getReadyMessageLine2"] as? String,
            retryTitle = screensMap["retryTitle"] as? String,
            retrySubtitle = screensMap["retrySubtitle"] as? String,
            retryTip1 = screensMap["retryTip1"] as? String,
            retryTip2 = screensMap["retryTip2"] as? String,
            yourImageLabel = screensMap["yourImageLabel"] as? String,
            idealImageLabel = screensMap["idealImageLabel"] as? String,
            reviewPhotoTitle = screensMap["reviewPhotoTitle"] as? String,
            reviewPhotoInstruction = screensMap["reviewPhotoInstruction"] as? String,
            uploadingMessage = screensMap["uploadingMessage"] as? String,
            uploadingSlowConnection = screensMap["uploadingSlowConnection"] as? String,
            successMessage = screensMap["successMessage"] as? String
        )

        val feedbackStrings = FeedbackStrings(
            noFaceDetected = feedbackMap["noFaceDetected"] as? String,
            multipleFaces = feedbackMap["multipleFaces"] as? String,
            faceCentered = feedbackMap["faceCentered"] as? String,
            tooClose = feedbackMap["tooClose"] as? String,
            tooFar = feedbackMap["tooFar"] as? String,
            tooLeft = feedbackMap["tooLeft"] as? String,
            tooRight = feedbackMap["tooRight"] as? String,
            tooHigh = feedbackMap["tooHigh"] as? String,
            tooLow = feedbackMap["tooLow"] as? String,
            moveToEyeLevel = feedbackMap["moveToEyeLevel"] as? String,
            invalidIED = feedbackMap["invalidIED"] as? String,
            faceAngleMisaligned = feedbackMap["faceAngleMisaligned"] as? String,
            lookStraightAhead = feedbackMap["lookStraightAhead"] as? String,
            holdHeadStraight = feedbackMap["holdHeadStraight"] as? String,
            closedEyes = feedbackMap["closedEyes"] as? String,
            smiling = feedbackMap["smiling"] as? String,
            neutralExpression = feedbackMap["neutralExpression"] as? String,
            removeDarkGlasses = feedbackMap["removeDarkGlasses"] as? String,
            tooDark = feedbackMap["tooDark"] as? String,
            tooBright = feedbackMap["tooBright"] as? String,
            lightFaceEvenly = feedbackMap["lightFaceEvenly"] as? String,
            brightenEnvironment = feedbackMap["brightenEnvironment"] as? String,
            holdSteady = feedbackMap["holdSteady"] as? String,
            frameYourFace = feedbackMap["frameYourFace"] as? String
        )

        val buttonStrings = ButtonStrings(
            back = buttonsMap["back"] as? String,
            capture = buttonsMap["capture"] as? String,
            switchCamera = buttonsMap["switchCamera"] as? String,
            flashOn = buttonsMap["flashOn"] as? String,
            flashOff = buttonsMap["flashOff"] as? String,
            imReady = buttonsMap["imReady"] as? String,
            tryAgain = buttonsMap["tryAgain"] as? String,
            ok = buttonsMap["ok"] as? String,
            continueButton = buttonsMap["continueButton"] as? String,
            retake = buttonsMap["retake"] as? String,
            submit = buttonsMap["submit"] as? String
        )

        val customStrings = LivenessStrings(
            screens = screenStrings,
            feedback = feedbackStrings,
            buttons = buttonStrings
        )

        return LivenessLocalization(
            language = language,
            customStrings = customStrings
        )
    }
}
