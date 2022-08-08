package com.solana.sms_wallet

import android.net.Uri
import android.os.Handler
import android.os.Looper
import com.solana.mobilewalletadapter.walletlib.scenario.*
import io.flutter.plugin.common.BinaryMessenger

object ApiHost : Api.ApiHost {
    private val scenarios = mutableMapOf<Long, Scenario>()

    fun init(binaryMessenger: BinaryMessenger) {
        Api.ApiHost.setup(binaryMessenger, this)
    }

    fun register(id: Long, scenario: Scenario) {
        scenarios[id] = scenario
    }

    fun unregister(id: Long) {
        scenarios.remove(id)
    }

    override fun start(id: Long) {
        scenarios[id]?.start()
    }

    override fun close(id: Long) {
        scenarios[id]?.close()
    }
}

class Callbacks(
    private val id: Long,
    binaryMessenger: BinaryMessenger,
    private val onTeardownComplete: () -> Unit
) : Scenario.Callbacks {
    private val api = Api.ApiFlutter(binaryMessenger)

    override fun onScenarioReady() {
        Handler(Looper.getMainLooper()).post { api.onScenarioReady(id) {} }
    }

    override fun onScenarioServingClients() {
        Handler(Looper.getMainLooper()).post { api.onScenarioServingClients(id) {} }
    }

    override fun onScenarioServingComplete() {
        Handler(Looper.getMainLooper()).post { api.onScenarioServingComplete(id) {} }
    }

    override fun onScenarioComplete() {
        Handler(Looper.getMainLooper()).post { api.onScenarioComplete(id) {} }
    }

    override fun onScenarioError() {
        Handler(Looper.getMainLooper()).post { api.onScenarioError(id) {} }
    }

    override fun onScenarioTeardownComplete() {
        Handler(Looper.getMainLooper()).post { api.onScenarioTeardownComplete(id) {} }
        onTeardownComplete()
    }

    override fun onAuthorizeRequest(request: AuthorizeRequest) {
        val dto = Api.AuthorizeRequest.Builder()
            .setIconUri(request.iconRelativeUri?.toString())
            .setIdentityName(request.identityName)
            .setIdentityUri(request.identityUri?.toString())
            .build()

        Handler(Looper.getMainLooper()).post {
            api.authorize(dto, id) { result ->
                if (result == null) {
                    request.completeWithDecline()
                } else {
                    request.completeWithAuthorize(
                        result.publicKey,
                        Uri.parse(result.walletUriBase),
                        result.scope,
                    )
                }
            }
        }
    }

    override fun onReauthorizeRequest(request: ReauthorizeRequest) {

    }

    override fun onSignTransactionsRequest(request: SignTransactionsRequest) {

    }

    override fun onSignMessagesRequest(request: SignMessagesRequest) {

    }

    override fun onSignAndSendTransactionsRequest(request: SignAndSendTransactionsRequest) {

    }

}