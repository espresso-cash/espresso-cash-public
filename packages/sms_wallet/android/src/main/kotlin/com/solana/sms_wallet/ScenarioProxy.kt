package com.solana.sms_wallet

import android.os.Handler
import android.os.Looper
import com.solana.mobilewalletadapter.walletlib.scenario.*
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ScenarioProxy(
    val id: Int,
    messenger: BinaryMessenger,
    private val onTeardownComplete: () -> Unit,
    create: (Scenario.Callbacks) -> Scenario
) :
    Scenario.Callbacks, MethodChannel.MethodCallHandler {
    private val channel = MethodChannel(messenger, "com.solana.sms.scenario#$id")
    private val scenario = create(this)

    init {
        channel.setMethodCallHandler(this)
        println("Channel $channel (ID=$id) created")
    }

    val associationPublicKey: ByteArray
        get() = scenario.associationPublicKey

    override fun onScenarioReady() {
        Handler(Looper.getMainLooper()).post {
            channel.invokeMethod("onScenarioReady", null)
        }
    }

    override fun onScenarioServingClients() {
        Handler(Looper.getMainLooper()).post {
            channel.invokeMethod("onScenarioServingClients", null)
        }
    }

    override fun onScenarioServingComplete() {
        Handler(Looper.getMainLooper()).post {
            channel.invokeMethod("onScenarioServingComplete", null)
        }
    }

    override fun onScenarioComplete() {
        Handler(Looper.getMainLooper()).post {
            channel.invokeMethod("onScenarioComplete", null)
        }
    }

    override fun onScenarioError() {
        Handler(Looper.getMainLooper()).post {
            channel.invokeMethod("onScenarioError", null)
        }
    }

    override fun onScenarioTeardownComplete() {
        Handler(Looper.getMainLooper()).post {
            channel.invokeMethod("onScenarioTeardownComplete", null)
        }
        onTeardownComplete()
    }

    override fun onAuthorizeRequest(request: AuthorizeRequest) {

    }

    override fun onReauthorizeRequest(request: ReauthorizeRequest) {

    }

    override fun onSignTransactionsRequest(request: SignTransactionsRequest) {

    }

    override fun onSignMessagesRequest(request: SignMessagesRequest) {

    }

    override fun onSignAndSendTransactionsRequest(request: SignAndSendTransactionsRequest) {

    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        println("onMethodCall: ${call.method}")
        when (call.method) {
            "start" -> scenario.start()
            "close" -> scenario.close()
        }
    }
}