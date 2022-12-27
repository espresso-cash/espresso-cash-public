package com.example.solana_seed_vault

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull
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
import io.flutter.plugin.common.PluginRegistry


/** SolanaSeedVaultPlugin */
class SolanaSeedVaultPlugin: FlutterPlugin, MethodCallHandler,  ActivityAware {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var walletApiHost : WalletApiHost;


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "solana_seed_vault")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext

    walletApiHost = WalletApiHost();
    walletApiHost.init(flutterPluginBinding.binaryMessenger, context)

    Bip32ApiHost().init(flutterPluginBinding.binaryMessenger, context)
    Bip44ApiHost().init(flutterPluginBinding.binaryMessenger, context)
    SeedVaultApiHost().init(flutterPluginBinding.binaryMessenger, context)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {}

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    binding.addActivityResultListener(walletApiHost)
    walletApiHost.setActivity(binding)
  }

  override fun onDetachedFromActivityForConfigChanges()  = Unit

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    binding.addActivityResultListener(walletApiHost)
    walletApiHost.setActivity(binding)
  }

  override fun onDetachedFromActivity() = Unit

}
