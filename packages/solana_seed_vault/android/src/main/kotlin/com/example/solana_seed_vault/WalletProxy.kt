package com.example.solana_seed_vault

import android.content.Context
import android.content.Intent
import android.database.Cursor
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.BinaryMessenger
import java.lang.IllegalArgumentException
import android.util.Log
import androidx.annotation.RequiresApi
import com.solana.solana_seed_vault.Api
import com.solana.solana_seed_vault.Api.AccountDto
import com.solana.solana_seed_vault.Api.ImplementationLimitsDto
import com.solana.solana_seed_vault.Api.SeedDto
import com.solana.solana_seed_vault.Api.SigningResponseDto
import com.solanamobile.seedvault.*
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.*
import java.util.concurrent.CompletableFuture
import java.util.concurrent.Future
import java.util.stream.Stream
import kotlin.coroutines.CoroutineContext
import kotlin.coroutines.suspendCoroutine

class WalletApiHost : PluginRegistry.ActivityResultListener, Api.WalletApiHost {
    private lateinit var context: Context
    private lateinit var binding: ActivityPluginBinding
    private lateinit var completable: CompletableFuture<Any>
    private var pendingRequest: Int? = null

    companion object {
        private val TAG = WalletApiHost::class.simpleName
        private const val REQUEST_AUTHORIZE_SEED_ACCESS = 0
        private const val REQUEST_CREATE_NEW_SEED = 1
        private const val REQUEST_IMPORT_EXISTING_SEED = 2
        private const val REQUEST_SIGN_TRANSACTIONS = 3
        private const val REQUEST_SIGN_MESSAGES = 4
        private const val REQUEST_GET_PUBLIC_KEYS = 5
    }

    fun init(binaryMessenger: BinaryMessenger, context: Context) {
        Api.WalletApiHost.setup(binaryMessenger, this)
        this.context = context
        this.completable = CompletableFuture()
    }

    fun setActivity(activity: ActivityPluginBinding) {
        this.binding = activity;
    }

    override fun authorizeSeed(purpose: Long, result: Api.Result<Long>?) {
        setupCompleter(result, REQUEST_AUTHORIZE_SEED_ACCESS) { it as Long }
        binding.activity.startActivityForResult(
            Wallet.authorizeSeed(purpose.toInt()),
            REQUEST_AUTHORIZE_SEED_ACCESS
        )
    }

    override fun createSeed(purpose: Long, result: Api.Result<Long>?) {
        setupCompleter(result, REQUEST_CREATE_NEW_SEED) { it as Long }
        binding.activity.startActivityForResult(
            Wallet.createSeed(purpose.toInt()),
            REQUEST_CREATE_NEW_SEED
        )
    }

    override fun importSeed(purpose: Long, result: Api.Result<Long>?) {
        setupCompleter(result, REQUEST_IMPORT_EXISTING_SEED) { it as Long }
        binding.activity.startActivityForResult(
            Wallet.importSeed(purpose.toInt()),
            REQUEST_IMPORT_EXISTING_SEED
        )
    }


    @RequiresApi(Build.VERSION_CODES.R)
    override fun getImplementationLimitsForPurpose(purpose: Long): ImplementationLimitsDto {
        val limits = Wallet.getImplementationLimitsForPurpose(context, purpose.toInt())

        return ImplementationLimitsDto.Builder()
            .setMaxBip32PathDepth(WalletContractV1.BIP32_URI_MAX_DEPTH.toLong())
            .setMaxRequestedPublicKeys(limits[WalletContractV1.IMPLEMENTATION_LIMITS_MAX_REQUESTED_PUBLIC_KEYS])
            .setMaxSigningRequests(limits[WalletContractV1.IMPLEMENTATION_LIMITS_MAX_SIGNING_REQUESTS])
            .setMaxRequestedSignatures(limits[WalletContractV1.IMPLEMENTATION_LIMITS_MAX_REQUESTED_SIGNATURES])
            .build()
    }


    override fun hasUnauthorizedSeedsForPurpose(purpose: Long): Boolean {
        return Wallet.hasUnauthorizedSeedsForPurpose(context, purpose.toInt())
    }
    override fun signMessages(
        authToken: Long,
        signingRequests: MutableList<Api.SigningRequestDto>,
        result: Api.Result<MutableList<Api.SigningResponseDto>>?
    ) {
        setupCompleter(result, REQUEST_SIGN_MESSAGES) { data ->
            val responses = data as ArrayList<SigningResponse>
            responses.map { r ->
                SigningResponseDto.Builder()
                    .setSignatures(r.signatures)
                    .setResolvedDerivationPaths(r.resolvedDerivationPaths.map { it.toString() })
                    .build()
            }.toMutableList()
        }

        val requests = ArrayList(signingRequests.map { it -> SigningRequest(it.payload, it.requestedSignatures.map { Uri.parse(it) }) })

        binding.activity.startActivityForResult(
            Wallet.signMessages(authToken, requests),
            REQUEST_SIGN_MESSAGES
        )
    }

    override fun signTransactions(
        authToken: Long,
        signingRequests: MutableList<Api.SigningRequestDto>,
        result: Api.Result<MutableList<SigningResponseDto>>?
    ) {
        setupCompleter(result, REQUEST_SIGN_TRANSACTIONS) { data ->
            val responses = data as ArrayList<SigningResponse>
            responses.map { r ->
                SigningResponseDto.Builder()
                    .setSignatures(r.signatures)
                    .setResolvedDerivationPaths(r.resolvedDerivationPaths.map { it.toString() })
                    .build()
            }.toMutableList()
        }

        val requests = ArrayList(signingRequests.map { it -> SigningRequest(it.payload, it.requestedSignatures.map { Uri.parse(it) }) })

        binding.activity.startActivityForResult(
            Wallet.signMessages(authToken, requests),
            REQUEST_SIGN_TRANSACTIONS
        )
    }


    override fun getAuthorizedSeeds(): MutableList<Api.SeedDto> {
        val seeds = mutableListOf<SeedDto>()

        val authorizedSeedsCursor =
            Wallet.getAuthorizedSeeds(
                context,
                WalletContractV1.AUTHORIZED_SEEDS_ALL_COLUMNS
            )!!

        while (authorizedSeedsCursor.moveToNext()) {
            val authToken = authorizedSeedsCursor.getLong(0)
            val authPurpose = authorizedSeedsCursor.getInt(1)
            val seedName = authorizedSeedsCursor.getString(2)
            val accounts = getAccounts(authToken, true)

            seeds.add(
                SeedDto.Builder()
                    .setAuthToken(authToken)
                    .setName(seedName.ifBlank { authToken.toString() })
                    .setPurpose(authPurpose.toLong())
                    .setAccounts(accounts)
                    .build()
            )
        }
        authorizedSeedsCursor.close()

        return seeds
    }

    override fun updateAccountIsValid(authToken: Long, accountId: Long, isValid: Boolean) {
        return Wallet.updateAccountIsValid(context, authToken, accountId, isValid)
    }

    override fun updateAccountIsUserWallet(
        authToken: Long,
        accountId: Long,
        isUserWallet: Boolean
    ) {
        return Wallet.updateAccountIsUserWallet(context, authToken, accountId, isUserWallet)
    }

    override fun updateAccountName(authToken: Long, accountId: Long, name: String?) {
        return Wallet.updateAccountName(context, authToken, accountId, name)
    }

    override fun deauthorizeSeed(authToken: Long) {
        return Wallet.deauthorizeSeed(context, authToken)
    }

    override fun resolveDerivationPath(derivationPath: String, purpose: Long): String {
        return Wallet.resolveDerivationPath(context, Uri.parse(derivationPath), purpose.toInt())
            .toString();
    }

    override fun getAccounts(authToken: Long, isUserWalletOnly: Boolean): MutableList<AccountDto> {
        val accounts = mutableListOf<AccountDto>()
        val filter =
            if (isUserWalletOnly) WalletContractV1.ACCOUNTS_ACCOUNT_IS_USER_WALLET else null
        val value = if (isUserWalletOnly) "1" else null

        val accountsCursor = Wallet.getAccounts(
            context,
            authToken,
            WalletContractV1.ACCOUNTS_ALL_COLUMNS,
            filter, value,
        )!!

        while (accountsCursor.moveToNext()) {
            val accountId = accountsCursor.getLong(0)
            val derivationPath = Uri.parse(accountsCursor.getString(1))
            val publicKeyEncoded = accountsCursor.getString(3)
            val accountName = accountsCursor.getString(4)
            val isUserWallet = accountsCursor.getShort(5) == 1.toShort()
            val isValid = accountsCursor.getShort(6) == 1.toShort()
            accounts.add(
                AccountDto.Builder()
                    .setId(accountId)
                    .setName(accountName.ifBlank { publicKeyEncoded.substring(0, 10) })
                    .setPublicKeyEncoded(publicKeyEncoded)
                    .setDerivationPath(derivationPath.toString())
                    .setIsUserWallet(isUserWallet)
                    .setIsValid(isValid)
                    .build()
            )
        }
        accountsCursor.close()

        return accounts;
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != pendingRequest) return false;
        Log.d(TAG, "Processing request code $requestCode")
        when (requestCode) {
            REQUEST_AUTHORIZE_SEED_ACCESS -> {
                handleResult { Wallet.onAuthorizeSeedResult(resultCode, data) }
            }
            REQUEST_CREATE_NEW_SEED -> {
                handleResult { Wallet.onCreateSeedResult(resultCode, data) }
            }
            REQUEST_IMPORT_EXISTING_SEED -> {
                handleResult { Wallet.onImportSeedResult(resultCode, data) }
            }
            REQUEST_SIGN_MESSAGES -> {
                handleResult { Wallet.onSignMessagesResult(resultCode, data) }
            }
            REQUEST_SIGN_TRANSACTIONS -> {
                handleResult { Wallet.onSignTransactionsResult(resultCode, data) }
            }
        }
        return false;
    }


    private fun <T : Any> setupCompleter(result: Api.Result<T>?, request: Int, parse: (Any) -> (T)) {
        completable.cancel(true)
        pendingRequest = request
        completable = CompletableFuture()
        completable.whenComplete { r, e -> if (r != null) result?.success(parse(r)) else result?.error(e) }
    }

    private fun <T: Any> handleResult(onComplete: () -> T) {
        try {
            val result = onComplete()
            Log.d(TAG, "Successfully completing with code $result")
            completable.complete(result)
        } catch (e: Wallet.ActionFailedException) {
            Log.e(TAG, "Exceptionally completing ", e)
            completable.completeExceptionally(e)
        }
    }

}
