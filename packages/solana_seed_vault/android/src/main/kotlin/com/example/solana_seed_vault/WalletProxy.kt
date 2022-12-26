package com.example.solana_seed_vault

import android.content.Context
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
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class WalletApiHost : Api.WalletApiHost {
    private lateinit var context: Context

    fun init(binaryMessenger: BinaryMessenger, context: Context) {
        Api.WalletApiHost.setup(binaryMessenger, this)
        this.context = context
    }

    @RequiresApi(Build.VERSION_CODES.R)
    override fun getImplementationLimitsForPurpose(purpose: Long):ImplementationLimitsDto {
        val limits =  Wallet.getImplementationLimitsForPurpose(context, purpose.toInt())

        return ImplementationLimitsDto.Builder()
            .setMaxBip32PathDepth(WalletContractV1.BIP32_URI_MAX_DEPTH.toLong())
            .setMaxRequestedPublicKeys(limits[WalletContractV1.IMPLEMENTATION_LIMITS_MAX_REQUESTED_PUBLIC_KEYS])
            .setAuthPurpose(limits[WalletContractV1.IMPLEMENTATION_LIMITS_AUTH_PURPOSE])
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
            Wallet.getAuthorizedSeeds(context,
                WalletContractV1.AUTHORIZED_SEEDS_ALL_COLUMNS)!!

        while (authorizedSeedsCursor.moveToNext()) {
            val authToken = authorizedSeedsCursor.getLong(0)
            val authPurpose = authorizedSeedsCursor.getInt(1)
            val seedName = authorizedSeedsCursor.getString(2)
            val accounts = getAccounts(authToken)

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

    override fun getAccounts(authToken: Long): MutableList<AccountDto> {
        val accounts = mutableListOf<AccountDto>()

        val accountsCursor =
            Wallet.getAccounts(context, authToken,
                WalletContractV1.ACCOUNTS_ALL_COLUMNS,
                WalletContractV1.ACCOUNTS_ACCOUNT_IS_USER_WALLET, "1")!!

        while (accountsCursor.moveToNext()) {
            val accountId = accountsCursor.getLong(0)
            val derivationPath = Uri.parse(accountsCursor.getString(1))
            val publicKeyEncoded = accountsCursor.getString(3)
            val accountName = accountsCursor.getString(4)
            accounts.add(
                AccountDto.Builder()
                    .setId(accountId)
                    .setName(accountName.ifBlank { publicKeyEncoded.substring(0, 10) })
                    .setPublicKeyEncoded(publicKeyEncoded)
                    .setDerivationPath(derivationPath.toString())
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


    companion object {
        private const val TAG = "WalletProxy"
    }
}