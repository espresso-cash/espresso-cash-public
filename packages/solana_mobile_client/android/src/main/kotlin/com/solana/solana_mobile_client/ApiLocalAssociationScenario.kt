package com.solana.solana_mobile_client

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.net.Uri
import com.solana.mobilewalletadapter.clientlib.protocol.MobileWalletAdapterClient
import com.solana.mobilewalletadapter.clientlib.scenario.LocalAssociationIntentCreator
import com.solana.mobilewalletadapter.clientlib.scenario.LocalAssociationScenario
import com.solana.mobilewalletadapter.clientlib.scenario.Scenario
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry

@SuppressLint("StaticFieldLeak")
object ApiLocalAssociationScenario : Api.ApiLocalAssociationScenario, ActivityAware,
    PluginRegistry.ActivityResultListener {
    private val scenarios: MutableMap<Long, LocalAssociationScenario> = mutableMapOf()
    private val clients: MutableMap<Long, MobileWalletAdapterClient> = mutableMapOf()
    private var activity: Activity? = null
    private var activityResult: Api.Result<Void>? = null


    override fun create(id: Long, result: Api.Result<Void>?) {
        val scenario = LocalAssociationScenario(Scenario.DEFAULT_CLIENT_TIMEOUT_MS)
        scenarios[id] = scenario
        result?.success(null)
    }

    override fun start(id: Long, result: Api.Result<Void>?) {
        val scenario = getScenario(id)

        scenario.start().notifyOnComplete {
            clients[id] = it.get()

            activity?.runOnUiThread { result?.success(null) }
        }
    }

    override fun close(id: Long, result: Api.Result<Void>?) {
        scenarios[id]?.close()
        scenarios.remove(id)
        clients.remove(id)
        result?.success(null)
    }

    override fun startActivityForResult(id: Long, uriPrefix: String?, result: Api.Result<Void>?) {
        val scenario = getScenario(id)
        val activity = this.activity
        if (activity == null) {
            result?.success(null)
            return
        }

        val associationIntent = LocalAssociationIntentCreator.createAssociationIntent(
            uriPrefix?.let(Uri::parse),
            scenario.port,
            scenario.session,
        )

        activityResult = result
        activity.startActivityForResult(associationIntent, WALLET_ACTIVITY_REQUEST_CODE)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != WALLET_ACTIVITY_REQUEST_CODE) return false

        activityResult?.success(null)
        activityResult = null

        return true
    }

    override fun getCapabilities(id: Long, result: Api.Result<Api.GetCapabilitiesResultDto>?) {
        val client = getClient(id)

        client.capabilities.notifyOnComplete {
            val capabilities = it.get()
            val dto = Api.GetCapabilitiesResultDto.Builder()
                .setMaxMessagesPerSigningRequest(capabilities.maxMessagesPerSigningRequest.toLong())
                .setMaxTransactionsPerSigningRequest(capabilities.maxTransactionsPerSigningRequest.toLong())
                .setSupportsCloneAuthorization(capabilities.supportsCloneAuthorization)
                .setSupportsSignAndSendTransactions(capabilities.supportsSignAndSendTransactions)
                .build()

            activity?.runOnUiThread { result?.success(dto) }
        }
    }

    override fun authorize(
        id: Long,
        identityUri: String?,
        iconUri: String?,
        identityName: String?,
        cluster: String?,
        result: Api.Result<Api.AuthorizationResultDto>?
    ) {
        val client = getClient(id)

        client.authorize(
            identityUri?.let(Uri::parse),
            iconUri?.let(Uri::parse),
            identityName,
            cluster,
        ).notifyOnComplete {
            try {
                val authResult = it.get()
                val dto = Api.AuthorizationResultDto.Builder()
                    .setAuthToken(authResult.authToken)
                    .setPublicKey(authResult.publicKey)
                    .setAccountLabel(authResult.accountLabel)
                    .setWalletUriBase(authResult.walletUriBase?.toString())
                    .build()

                activity?.runOnUiThread { result?.success(dto) }
            } catch (e: Throwable) {
                activity?.runOnUiThread { result?.error(e) }
            }
        }
    }

    override fun reauthorize(
        id: Long,
        identityUri: String?,
        iconUri: String?,
        identityName: String?,
        authToken: String,
        result: Api.Result<Api.AuthorizationResultDto>?
    ) {
        val client = getClient(id)

        client.reauthorize(
            identityUri?.let(Uri::parse),
            iconUri?.let(Uri::parse),
            identityName,
            authToken,
        ).notifyOnComplete {
            try {
                val authResult = it.get()
                val dto = Api.AuthorizationResultDto.Builder()
                    .setAuthToken(authResult.authToken)
                    .setPublicKey(authResult.publicKey)
                    .setAccountLabel(authResult.accountLabel)
                    .setWalletUriBase(authResult.walletUriBase?.toString())
                    .build()

                activity?.runOnUiThread { result?.success(dto) }
            } catch (e: Throwable) {
                activity?.runOnUiThread { result?.error(e) }
            }
        }
    }

    override fun deauthorize(id: Long, authToken: String, result: Api.Result<Void>?) {
        val client = getClient(id)

        client.deauthorize(authToken)
            .notifyOnComplete { activity?.runOnUiThread { result?.success(null) } }
    }

    override fun signTransactions(
        id: Long,
        transactions: MutableList<ByteArray>,
        result: Api.Result<Api.SignPayloadsResultDto>?
    ) {
        val client = getClient(id)

        client.signTransactions(transactions.toTypedArray()).notifyOnComplete {
            try {
                val response = it.get()
                val dto = Api.SignPayloadsResultDto.Builder()
                    .setSignedPayloads(response.signedPayloads.toList())
                    .build()

                activity?.runOnUiThread { result?.success(dto) }
            } catch (e: Throwable) {
                activity?.runOnUiThread { result?.error(e) }
            }
        }
    }

    override fun signMessages(
        id: Long,
        messages: MutableList<ByteArray>,
        addresses: MutableList<ByteArray>,
        result: Api.Result<Api.SignMessagesResultDto>?
    ) {
        val client = getClient(id)

        client.signMessagesDetached(messages.toTypedArray(), addresses.toTypedArray())
            .notifyOnComplete {
                try {
                    val response = it.get()
                    val messages = response.messages.map {
                        r ->
                        Api.SignedMessageDto.Builder()
                            .setMessage(r.message)
                            .setSignatures(r.signatures.toList())
                            .setAddresses(r.addresses.toList())
                            .build()
                    }
                    val dto = Api.SignMessagesResultDto.Builder()
                        .setMessages(messages.toList())
                        .build()

                    activity?.runOnUiThread { result?.success(dto) }
                } catch (e: Throwable) {
                    activity?.runOnUiThread { result?.error(e) }
                }
            }
    }

    override fun signAndSendTransactions(
        id: Long,
        transactions: MutableList<ByteArray>,
        minContextSlot: Long?,
        result: Api.Result<Api.SignAndSendTransactionsResultDto>?
    ) {
        val client = getClient(id)

        client.signAndSendTransactions(transactions.toTypedArray(), minContextSlot?.toInt())
            .notifyOnComplete {
                try {
                    val response = it.get()
                    val dto = Api.SignAndSendTransactionsResultDto.Builder()
                        .setSignatures(response.signatures.toList())
                        .build()

                    activity?.runOnUiThread { result?.success(dto) }
                } catch (e: Throwable) {
                    activity?.runOnUiThread { result?.error(e) }
                }
            }
    }

    private fun getScenario(id: Long): LocalAssociationScenario =
        scenarios[id] ?: throw IllegalStateException("No scenario with id $id registered")

    private fun getClient(id: Long): MobileWalletAdapterClient =
        clients[id] ?: throw IllegalStateException("No client with id $id registered")

    private const val WALLET_ACTIVITY_REQUEST_CODE = 1234
}