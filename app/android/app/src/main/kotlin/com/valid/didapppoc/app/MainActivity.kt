package com.valid.didapppoc.app

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.credentials.CredentialManager
import androidx.credentials.CreateDigitalCredentialRequest
import androidx.credentials.ExperimentalDigitalCredentialApi
import androidx.credentials.exceptions.CreateCredentialException
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.launch

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.valid.wallet/provisioning"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "addCredential") {
                val offerJson = call.argument<String>("offerJson")
                if (offerJson != null) {
                    provisionCredential(offerJson, result)
                } else {
                    result.error("INVALID_ARGUMENT", "offerJson cannot be null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    @OptIn(ExperimentalDigitalCredentialApi::class)
    private fun provisionCredential(offerJson: String, result: MethodChannel.Result) {
        val credentialManager = CredentialManager.create(this)

        lifecycleScope.launch {
            try {
                val request = CreateDigitalCredentialRequest(
                    requestJson = offerJson,
                    origin = null,
                )
                credentialManager.createCredential(this@MainActivity, request)
                result.success(true)
            } catch (e: CreateCredentialException) {
                result.error("CREDENTIAL_ERROR", e.message, e.type)
            } catch (e: Exception) {
                result.error("UNKNOWN_ERROR", e.message, null)
            }
        }
    }
}
