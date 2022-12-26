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
import com.solanamobile.seedvault.*
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class WalletApiHost : PluginRegistry.ActivityResultListener, Api.WalletApiHost {
    private lateinit var context: Context
    private lateinit var binding: ActivityPluginBinding


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
    }

    fun setActivity(activity: ActivityPluginBinding) {
        this.binding = activity;
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

    @RequiresApi(Build.VERSION_CODES.M)
    override fun isAvailable(allowSimulated: Boolean): Boolean {
        return SeedVault.isAvailable(context, allowSimulated)
    }

    override fun authorizeSeed(purpose: Long) {
        binding.activity.startActivityForResult(
            Wallet.authorizeSeed(purpose.toInt()),
            REQUEST_AUTHORIZE_SEED_ACCESS
        )
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) : Boolean {
//    TODO: implement callbacks
        when (requestCode) {
            REQUEST_AUTHORIZE_SEED_ACCESS -> {
                try {
                    val authToken = Wallet.onAuthorizeSeedResult(resultCode, data)
                    Log.d(TAG, "Seed authorized, AuthToken=$authToken")
                    //           onAddSeedSuccess(authToken)
                } catch (e: Wallet.ActionFailedException) {
                    Log.e(TAG, "Seed authorization failed", e)
                    //          onAddSeedSuccessdFailure(resultCode)
                }
            }
        }
        return false;
    }
}
