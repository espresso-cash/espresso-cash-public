package com.solana.solana_mobile_wallet

import android.content.Context
import android.content.Intent
import android.util.Log
import com.solana.mobilewalletadapter.walletlib.association.AssociationUri
import com.solana.mobilewalletadapter.walletlib.association.LocalAssociationUri
import com.solana.mobilewalletadapter.walletlib.authorization.AuthIssuerConfig
import com.solana.mobilewalletadapter.walletlib.protocol.MobileWalletAdapterConfig
import com.solana.mobilewalletadapter.walletlib.scenario.Scenario
import io.flutter.plugin.common.BinaryMessenger

class ApiHost(private val context: Context, private val api: Api.ApiFlutter) : Api.ApiHost {
    private val scenarios = mutableMapOf<Long, Scenario>()
    private var intent: Intent? = null

    fun setIntent(intent: Intent) {
        this.intent = intent
    }

    fun init(binaryMessenger: BinaryMessenger) {
        Api.ApiHost.setup(binaryMessenger, this)
    }

    private fun register(id: Long, scenario: Scenario) {
        scenarios[id] = scenario
    }

    private fun unregister(id: Long) {
        scenarios.remove(id)
    }

    override fun start(id: Long) {
        scenarios[id]?.start()
    }

    override fun close(id: Long) {
        scenarios[id]?.close()
    }

    override fun createScenario(
        id: Long,
        walletConfig: Api.WalletConfigDto,
        authIssuerConfig: Api.AuthIssuerConfigDto,
        result: Api.Result<ByteArray>?
    ) {
        val intent = this.intent
        if (intent == null) {
            result?.success(null)
        } else {
            val associationUri = intent.data?.let { uri -> AssociationUri.parse(uri) }

            if (associationUri == null) {
                Log.e(TAG, "Unsupported association URI '${intent.data}'")
                result?.success(null)
                return
            } else if (associationUri !is LocalAssociationUri) {
                result?.error(NotImplementedError())
                Log.w(TAG, "Current implementation of wallet does not support remote clients")
                return
            }

            Log.e(TAG, "Supported URI: $associationUri")

            val scenario = associationUri.createScenario(
                context,
                MobileWalletAdapterConfig(
                    walletConfig.supportsSignAndSendTransactions,
                    walletConfig.maxTransactionsPerSigningRequest.toInt(),
                    walletConfig.maxMessagesPerSigningRequest.toInt(),
                    walletConfig.supportedTransactionVersions.toTypedArray(),
                    walletConfig.noConnectionWarningTimeoutInMs,
                ),
                AuthIssuerConfig(
                    authIssuerConfig.name,
                    authIssuerConfig.maxOutstandingTokensPerIdentility.toInt(),
                    authIssuerConfig.authorizationValidityInMs,
                    authIssuerConfig.reauthorizationValidityInMs,
                    authIssuerConfig.reauthorizationValidityInMs,
                ),
                Callbacks(id, api) { unregister(id) },
            )
            register(id, scenario)

            result?.success(scenario.associationPublicKey)
        }
    }


    companion object {
        private const val TAG = "SolanaMobileWalletPlugin"
    }

}