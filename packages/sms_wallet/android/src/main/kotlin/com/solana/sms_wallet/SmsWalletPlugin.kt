package com.solana.sms_wallet

import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import com.solana.mobilewalletadapter.walletlib.association.AssociationUri
import com.solana.mobilewalletadapter.walletlib.association.LocalAssociationUri
import com.solana.mobilewalletadapter.walletlib.authorization.AuthIssuerConfig
import com.solana.mobilewalletadapter.walletlib.protocol.MobileWalletAdapterConfig
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class SmsWalletPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private var intent: Intent? = null
    private lateinit var context: Context
    private lateinit var messenger: BinaryMessenger

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        messenger = flutterPluginBinding.binaryMessenger
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.solana.sms.wallet")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext

        ApiHost.init(flutterPluginBinding.binaryMessenger)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "createScenario") {
            val intent = this.intent
            if (intent == null) {
                result.success(null)
            } else {
                val associationUri = intent.data?.let { uri -> AssociationUri.parse(uri) }

                if (associationUri == null) {
                    Log.e(TAG, "Unsupported association URI '${intent.data}'")
                    result.success(null)
                    return
                } else if (associationUri !is LocalAssociationUri) {
                    result.error("NotImplemented", "Not implemented", null)
                    Log.w(TAG, "Current implementation of wallet does not support remote clients")
                    return
                }

                Log.e(TAG, "Supported URI: $associationUri")

                val arguments = call.arguments as Map<String, Any?>
                val id = (arguments["id"] as Number).toLong()

                val walletConfig = arguments["walletConfig"] as Map<String, Any?>
                val issuerConfig = arguments["issuerConfig"] as Map<String, Any?>

                val scenario = associationUri.createScenario(
                    context,
                    MobileWalletAdapterConfig(
                        walletConfig["supportsSignAndSendTransactions"] as Boolean,
                        walletConfig["maxTransactionsPerSigningRequest"] as Int,
                        walletConfig["maxMessagesPerSigningRequest"] as Int,
                    ),
                    AuthIssuerConfig(
                        issuerConfig["name"] as String,
                        issuerConfig["maxOutstandingTokensPerIdentity"] as Int,
                        (issuerConfig["authorizationValidity"] as Number).toLong() / 1000,
                        (issuerConfig["reauthorizationValidity"] as Number).toLong() / 1000,
                        (issuerConfig["reauthorizationNopDuration"] as Number).toLong() / 1000,
                    ),
                    Callbacks(id, messenger) { ApiHost.unregister(id) },
                )
                ApiHost.register(id, scenario)

                result.success(scenario.associationPublicKey)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        intent = binding.activity.intent
    }

    override fun onDetachedFromActivityForConfigChanges() = Unit

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) = Unit

    override fun onDetachedFromActivity() = Unit

    companion object {
        private const val TAG = "SmsWalletPlugin"
    }
}
