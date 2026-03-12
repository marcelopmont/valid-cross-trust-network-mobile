package com.valid.didapppoc.app

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.credentials.CredentialManager
import androidx.credentials.CreateDigitalCredentialRequest
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

    private fun provisionCredential(offerJson: String, result: MethodChannel.Result) {
        val credentialManager = CredentialManager.create(this)
        
        // Use a coroutine scope since createCredential is a suspend function
        lifecycleScope.launch {
            try {
                val request = CreateDigitalCredentialRequest(offerJson)
                // Note: The second parameter is context/activity depending on overloaded method.
                // In Activity context, 'this@MainActivity' works.
                credentialManager.createCredential(this@MainActivity, request)
                // If it completes without throwing an exception, it's considered successful.
                result.success(true)
            } catch (e: CreateCredentialException) {
                // Return specific credential errors
                result.error("CREDENTIAL_ERROR", e.message, e.javaClass.simpleName)
            } catch (e: Exception) {
                // Return generic errors
                result.error("UNKNOWN_ERROR", e.message, null)
            }
        }
    }
}