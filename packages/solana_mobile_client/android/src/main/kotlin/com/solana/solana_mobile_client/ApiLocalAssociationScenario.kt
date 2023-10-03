package com.solana.solana_mobile_client

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Looper
import androidx.lifecycle.LifecycleOwner
import com.solana.mobilewalletadapter.clientlib.protocol.MobileWalletAdapterClient
import com.solana.mobilewalletadapter.clientlib.scenario.LocalAssociationIntentCreator
import com.solana.mobilewalletadapter.clientlib.scenario.LocalAssociationScenario
import com.solana.mobilewalletadapter.clientlib.scenario.Scenario
import com.solana.mobilewalletadapter.common.util.NotifyOnCompleteFuture
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.runInterruptible
import java.lang.Exception
import java.util.concurrent.Future
import java.util.logging.Handler

@SuppressLint("StaticFieldLeak")
object ApiLocalAssociationScenario : Api.ApiLocalAssociationScenario, ActivityAware,
    PluginRegistry.ActivityResultListener {
    private val scenarios: MutableMap<Long, LocalAssociationScenario> = mutableMapOf()
    private val clients: MutableMap<Long, MobileWalletAdapterClient> = mutableMapOf()
    private var activity: Activity? = null
    private var activityResult: Api.Result<Void>? = null

    override fun isWalletEndpointAvailable(): Boolean {
        return LocalAssociationIntentCreator.isWalletEndpointAvailable(activity!!.packageManager)
    }

    override fun create(id: Long, result: Api.Result<Void>?) {
        val scenario = LocalAssociationScenario(Scenario.DEFAULT_CLIENT_TIMEOUT_MS)
        scenarios[id] = scenario
        result?.success(null)
    }

    override fun start(id: Long, result: Api.Result<Void>?) {
        runWithResult(result) {
            val scenario = getScenario(id)
            clients[id] = scenario.start().get()

            null
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
        runWithResult(result) {
            val client = getClient(id)
            val capabilities = client.capabilities.get()

            Api.GetCapabilitiesResultDto.Builder()
                .setMaxMessagesPerSigningRequest(capabilities.maxMessagesPerSigningRequest.toLong())
                .setMaxTransactionsPerSigningRequest(capabilities.maxTransactionsPerSigningRequest.toLong())
                .setSupportsCloneAuthorization(capabilities.supportsCloneAuthorization)
                .setSupportsSignAndSendTransactions(capabilities.supportsSignAndSendTransactions)
                .build()
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
        runWithResult(result) {
            val client = getClient(id)

            val authResult = client.authorize(
                identityUri?.let(Uri::parse),
                iconUri?.let(Uri::parse),
                identityName,
                cluster,
            ).get()

            Api.AuthorizationResultDto.Builder()
                .setAuthToken(authResult.authToken)
                .setPublicKey(authResult.publicKey)
                .setAccountLabel(authResult.accountLabel)
                .setWalletUriBase(authResult.walletUriBase?.toString())
                .build()
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
        runWithResult(result) {
            val client = getClient(id)

            val authResult = client.reauthorize(
                identityUri?.let(Uri::parse),
                iconUri?.let(Uri::parse),
                identityName,
                authToken,
            ).get()

            Api.AuthorizationResultDto.Builder()
                .setAuthToken(authResult.authToken)
                .setPublicKey(authResult.publicKey)
                .setAccountLabel(authResult.accountLabel)
                .setWalletUriBase(authResult.walletUriBase?.toString())
                .build()
        }
    }

    override fun deauthorize(id: Long, authToken: String, result: Api.Result<Void>?) {
        runWithResult(result) {
            val client = getClient(id)
            client.deauthorize(authToken).get()

            null
        }
    }

    override fun signTransactions(
        id: Long,
        transactions: MutableList<ByteArray>,
        result: Api.Result<Api.SignPayloadsResultDto>?
    ) {
        runWithResult(result) {
            val client = getClient(id)

            val response = client.signTransactions(transactions.toTypedArray()).get()

            Api.SignPayloadsResultDto.Builder()
                .setSignedPayloads(response.signedPayloads.toList())
                .build()
        }
    }

    override fun signMessages(
        id: Long,
        messages: MutableList<ByteArray>,
        addresses: MutableList<ByteArray>,
        result: Api.Result<Api.SignMessagesResultDto>?
    ) {
        runWithResult(result) {
            val client = getClient(id)

            val response = client
                .signMessagesDetached(messages.toTypedArray(), addresses.toTypedArray())
                .get()
            val messages = response.messages.map { r ->
                Api.SignedMessageDto.Builder().setMessage(r.message)
                    .setSignatures(r.signatures.toList())
                    .setAddresses(r.addresses.toList())
                    .build()
            }

            Api.SignMessagesResultDto.Builder()
                .setMessages(messages.toList())
                .build()
        }
    }

    override fun signAndSendTransactions(
        id: Long,
        transactions: MutableList<ByteArray>,
        minContextSlot: Long?,
        result: Api.Result<Api.SignAndSendTransactionsResultDto>?
    ) {
        runWithResult(result) {
            val client = getClient(id)

            val response = client
                .signAndSendTransactions(transactions.toTypedArray(), minContextSlot?.toInt())
                .get()

            Api.SignAndSendTransactionsResultDto.Builder()
                .setSignatures(response.signatures.toList())
                .build()
        }
    }

    private fun <T> runWithResult(result: Api.Result<T>?, block: () -> T?) {
        Thread().run {
            try {
                val taskResult = block()
                activity?.runOnUiThread { result?.success(taskResult) }
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