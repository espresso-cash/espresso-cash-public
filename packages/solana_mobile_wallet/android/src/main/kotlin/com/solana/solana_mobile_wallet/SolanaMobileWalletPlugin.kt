package com.solana.solana_mobile_wallet

import android.content.Intent
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class SolanaMobileWalletPlugin : FlutterPlugin, ActivityAware {
    private var initialIntent = true
    private lateinit var apiFlutter: Api.ApiFlutter
    private lateinit var apiHost: ApiHost

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        apiFlutter = Api.ApiFlutter(flutterPluginBinding.binaryMessenger)
        apiHost = ApiHost(flutterPluginBinding.applicationContext, apiFlutter)
        apiHost.init(flutterPluginBinding.binaryMessenger)
    }


    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        binding.addOnNewIntentListener(fun(intent: Intent?): Boolean {
            intent?.let { handleIntent(it) }
            return false
        })
        handleIntent(binding.activity.intent)
    }


    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        binding.addOnNewIntentListener(fun(intent: Intent?): Boolean {
            intent?.let { handleIntent(it) }
            return false
        })
        handleIntent(binding.activity.intent)
    }

    private fun handleIntent(intent: Intent) {
        if (initialIntent) initialIntent = false
        apiHost.setIntent(intent)
        Handler(Looper.getMainLooper()).post { apiFlutter.onNewIntent(initialIntent) {} }
    }

    override fun onDetachedFromActivityForConfigChanges() = Unit

    override fun onDetachedFromActivity() = Unit

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) = Unit
}
