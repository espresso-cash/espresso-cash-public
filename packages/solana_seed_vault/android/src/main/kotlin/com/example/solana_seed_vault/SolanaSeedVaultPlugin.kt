package com.example.solana_seed_vault

import android.app.Activity
import android.content.Context
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.solana.solana_seed_vault.Api
import com.solanamobile.seedvault.SeedVault
import com.solanamobile.seedvault.Wallet
import com.solanamobile.seedvault.WalletContractV1

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SolanaSeedVaultPlugin */
class SolanaSeedVaultPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, Api.WalletApiHost {
  private lateinit var channel : MethodChannel
  private lateinit var activity: Activity
  private lateinit var context: Context


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "solana_seed_vault")
    channel.setMethodCallHandler(this)

    context = flutterPluginBinding.applicationContext

    Api.WalletApiHost.setup(flutterPluginBinding.binaryMessenger, this)
    Bip32ApiHost().init(flutterPluginBinding.binaryMessenger, context)
    Bip44ApiHost().init(flutterPluginBinding.binaryMessenger, context)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {}

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() = Unit

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) = Unit

  override fun onDetachedFromActivity() = Unit


  @RequiresApi(Build.VERSION_CODES.R)
  override fun getImplementationLimitsForPurpose(purpose: Long): Api.ImplementationLimitsDto {
    val limits =  Wallet.getImplementationLimitsForPurpose(context, purpose.toInt())

    return Api.ImplementationLimitsDto.Builder()
      .setMaxBip32PathDepth(WalletContractV1.BIP32_URI_MAX_DEPTH.toLong())
      .setMaxRequestedPublicKeys(limits[WalletContractV1.IMPLEMENTATION_LIMITS_MAX_REQUESTED_PUBLIC_KEYS])
      .setMaxSigningRequests(limits[WalletContractV1.IMPLEMENTATION_LIMITS_MAX_SIGNING_REQUESTS])
      .setMaxRequestedSignatures(limits[WalletContractV1.IMPLEMENTATION_LIMITS_MAX_REQUESTED_SIGNATURES])
      .build()
  }

  override fun hasUnauthorizedSeedsForPurpose(purpose: Long): Boolean {
    return Wallet.hasUnauthorizedSeedsForPurpose(context, purpose.toInt())
  }

  override fun authorizeSeed(purpose: Long) {
    @Suppress("deprecation")
    activity.startActivityForResult(Wallet.authorizeSeed(purpose.toInt()), 0)
  }

  override fun getAuthorizedSeeds(): MutableList<Api.SeedDto> {
    val seeds = mutableListOf<Api.SeedDto>()

    val authorizedSeedsCursor =
      Wallet.getAuthorizedSeeds(context,
        WalletContractV1.AUTHORIZED_SEEDS_ALL_COLUMNS)!!

    while (authorizedSeedsCursor.moveToNext()) {
      val authToken = authorizedSeedsCursor.getLong(0)
      val authPurpose = authorizedSeedsCursor.getInt(1)
      val seedName = authorizedSeedsCursor.getString(2)
      val accounts = getAccounts(authToken, true)

      seeds.add(
        Api.SeedDto.Builder()
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
    return Wallet.resolveDerivationPath(context, Uri.parse(derivationPath), purpose.toInt()).toString();
  }

  override fun getAccounts(authToken: Long, isUserWalletOnly : Boolean): MutableList<Api.AccountDto> {
    val accounts = mutableListOf<Api.AccountDto>()
    val filter = if (isUserWalletOnly) WalletContractV1.ACCOUNTS_ACCOUNT_IS_USER_WALLET else null
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
        Api.AccountDto.Builder()
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

}
