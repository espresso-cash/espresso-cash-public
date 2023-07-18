package com.solana.solana_mobile_wallet

import android.net.Uri
import android.os.Handler
import android.os.Looper
import com.solana.mobilewalletadapter.walletlib.scenario.*

class Callbacks(
    private val id: Long,
    private val api: Api.ApiFlutter,
    private val onTeardownComplete: () -> Unit
) : LocalScenario.Callbacks {
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
        val dto = Api.AuthorizeRequestDto.Builder()
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
                        result.accountLabel,
                        if (result.walletUriBase == null) null else Uri.parse(result.walletUriBase),
                        result.scope,
                    )
                }
            }
        }
    }

    override fun onReauthorizeRequest(request: ReauthorizeRequest) {
        val dto = Api.ReauthorizeRequestDto.Builder()
            .setIdentityName(request.identityName)
            .setIdentityUri(request.identityUri?.toString())
            .setIconRelativeUri(request.iconRelativeUri?.toString())
            .setCluster(request.cluster)
            .setAuthorizationScope(request.authorizationScope)
            .build()

        Handler(Looper.getMainLooper()).post {
            api.reauthorize(dto, id) { result ->
                if (result == true) {
                    request.completeWithReauthorize()
                } else {
                    request.completeWithDecline()
                }
            }
        }
    }

    override fun onSignTransactionsRequest(request: SignTransactionsRequest) {
        val dto = Api.SignTransactionsRequestDto.Builder()
            .setIdentityName(request.identityName)
            .setIdentityUri(request.identityUri?.toString())
            .setIconRelativeUri(request.iconRelativeUri?.toString())
            .setCluster(request.cluster)
            .setAuthorizationScope(request.authorizationScope)
            .setPayloads(request.payloads.toList())
            .build()

        Handler(Looper.getMainLooper()).post {
            api.signTransactions(dto, id) {
                when (it.error) {
                    Api.MobileWalletAdapterServerException.REQUEST_DECLINED -> request.completeWithDecline()
                    Api.MobileWalletAdapterServerException.INVALID_PAYLOADS -> request.completeWithInvalidPayloads(
                        it.validPayloads!!.toBooleanArray()
                    )
                    Api.MobileWalletAdapterServerException.TOO_MANY_PAYLOADS -> request.completeWithTooManyPayloads()
                    Api.MobileWalletAdapterServerException.AUTHORIZATION_NOT_VALID -> request.completeWithAuthorizationNotValid()
                    null -> request.completeWithSignedPayloads(it.payloads!!.toTypedArray())
                    else -> request.completeWithInternalError(IllegalArgumentException(it.error.toString()))
                }
            }
        }
    }

    override fun onSignMessagesRequest(request: SignMessagesRequest) {
        val dto = Api.SignMessagesRequestDto.Builder()
            .setIdentityName(request.identityName)
            .setIdentityUri(request.identityUri?.toString())
            .setIconRelativeUri(request.iconRelativeUri?.toString())
            .setCluster(request.cluster)
            .setAuthorizationScope(request.authorizationScope)
            .setPayloads(request.payloads.toList())
            .build()

        Handler(Looper.getMainLooper()).post {
            api.signMessages(dto, id) {
                when (it.error) {
                    Api.MobileWalletAdapterServerException.REQUEST_DECLINED -> request.completeWithDecline()
                    Api.MobileWalletAdapterServerException.INVALID_PAYLOADS -> request.completeWithInvalidPayloads(
                        it.validPayloads!!.toBooleanArray()
                    )
                    Api.MobileWalletAdapterServerException.TOO_MANY_PAYLOADS -> request.completeWithTooManyPayloads()
                    Api.MobileWalletAdapterServerException.AUTHORIZATION_NOT_VALID -> request.completeWithAuthorizationNotValid()
                    null -> request.completeWithSignedPayloads(it.payloads!!.toTypedArray())
                    else -> request.completeWithInternalError(IllegalArgumentException(it.error.toString()))
                }
            }
        }
    }

    override fun onSignAndSendTransactionsRequest(request: SignAndSendTransactionsRequest) {
        val dto = Api.SignAndSendTransactionsRequestDto.Builder()
            .setIdentityName(request.identityName)
            .setIdentityUri(request.identityUri?.toString())
            .setIconRelativeUri(request.iconRelativeUri?.toString())
            .setCluster(request.cluster)
            .setAuthorizationScope(request.authorizationScope)
            .setTransactions(request.payloads.toList())
            .setMinContextSlot(request.minContextSlot?.toLong())
            .setPublicKey(request.publicKey)
            .build()

        Handler(Looper.getMainLooper()).post {
            api.signAndSendTransactions(dto, id) {
                when (it.error) {
                    Api.MobileWalletAdapterServerException.NOT_SUBMITTED -> request.completeWithNotSubmitted(
                        it.signatures!!.toTypedArray()
                    )
                    Api.MobileWalletAdapterServerException.INVALID_PAYLOADS -> request.completeWithInvalidSignatures(
                        it.validSignatures!!.toBooleanArray()
                    )
                    Api.MobileWalletAdapterServerException.TOO_MANY_PAYLOADS -> request.completeWithTooManyPayloads()
                    Api.MobileWalletAdapterServerException.AUTHORIZATION_NOT_VALID -> request.completeWithAuthorizationNotValid()
                    Api.MobileWalletAdapterServerException.REQUEST_DECLINED -> request.completeWithDecline()
                    null -> request.completeWithSignatures(it.signatures!!.toTypedArray())
                }
            }
        }
    }

    override fun onDeauthorizedEvent(event: DeauthorizedEvent) {
        val dto = Api.DeauthorizeEventDto.Builder()
            .setIdentityName(event.identityName)
            .setIdentityUri(event.identityUri?.toString())
            .setIconRelativeUri(event.iconRelativeUri?.toString())
            .setCluster(event.cluster)
            .setAuthorizationScope(event.authorizationScope)
            .build()

        Handler(Looper.getMainLooper()).post {
            api.deauthorize(dto, id) {
                event.complete()
            }
        }
    }

    override fun onLowPowerAndNoConnection() {
        Handler(Looper.getMainLooper()).post { api.onLowPowerAndNoConnection(id) {} }
    }
}
